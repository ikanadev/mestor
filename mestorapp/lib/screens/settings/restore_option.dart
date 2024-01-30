import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mestorapp/db/models/models.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/providers/providers.dart';
import 'package:pick_or_save/pick_or_save.dart';
import 'package:mestorapp/providers/records.dart';

class RestoreOption extends ConsumerWidget {
  const RestoreOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void restoreBackup() async {
      try {
        final content = await readFileContentFromStorage();
        final appData = parseAppData(content);
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm restoration"),
            content: const Text(
                "By restoring from backup file, all the current data will be replaced. Proceed?"),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                  child: const Text("Proceed"),
                  onPressed: () async {
                    restoreAppData(appData).then((_) {
                      ref.invalidate(activityProvider);
                      ref.invalidate(activitiesProvider);
                      ref.invalidate(recordsProvider);
                      Navigator.of(context).pop();
                      context.go("/");
                    });
                  }),
            ],
          ),
        );
      } catch (e) {
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Can not restore"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    }

    return ListTile(
      leading: const Icon(Icons.restore_rounded),
      title: const Text("Restore data"),
      onTap: restoreBackup,
    );
  }
}

Future<void> restoreAppData(AppData data) async {
  try {
    final db = AppRepo.db;
    await db.recordDb.deleteAll();
    await db.activityDb.deleteAll();
    await db.batch((batch) {
      // restore activities
      final actsToInsert = data.activities.map((a) {
        return ActivityDbCompanion.insert(
          id: a.id,
          name: a.name,
          emoji: a.emoji,
          color: a.color,
          createdAt: a.createAt,
          deletedAt: Value(a.deletedAt),
        );
      }).toList();
      batch.insertAll(db.activityDb, actsToInsert);
      // restore records
      List<RecordDbCompanion> recordsToInsert = [];
      for (final recGroup in data.records.entries) {
        final actId = recGroup.key;
        for (var r in recGroup.value) {
          recordsToInsert.add(RecordDbCompanion.insert(
            id: r.id,
            createdAt: r.createAt,
            activityId: actId,
          ));
        }
      }
      batch.insertAll(db.recordDb, recordsToInsert);
    });
  } catch (e) {
    throw Exception('Error restarting data');
  }
}

AppData parseAppData(String data) {
  try {
    return AppData.fromJson(jsonDecode(data));
  } catch (e) {
    throw Exception('Unknow file content');
  }
}

Future<String> readFileContentFromStorage() async {
  try {
    final filePaths = await PickOrSave().filePicker(
      params: FilePickerParams(
        allowedExtensions: [".json"],
        pickerType: PickerType.file,
      ),
    );
    if (filePaths == null || filePaths.isEmpty) {
      throw Exception('No file selected');
    }
    File file = File(filePaths[0]);
    final content = await file.readAsString();
    return content;
  } catch (e) {
    throw Exception('Error reading file');
  }
}
