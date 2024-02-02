import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:kount/domain/models/models.dart';
import 'package:kount/providers/providers.dart';
import 'package:pick_or_save/pick_or_save.dart';

class BackupOption extends StatelessWidget {
  const BackupOption({super.key});

  @override
  Widget build(context) {
    void handleBackupData() async {
      try {
        final now = DateTime.now();
        final data = await getAppDataJson();
        String fileName =
            'mestor_backup_${now.year}_${now.month}_${now.day}_${now.hour}${now.minute}${now.second}.json';
        await PickOrSave().fileSaver(
          params: FileSaverParams(
            saveFiles: [
              SaveFileInfo(
                fileName: fileName,
                fileData: utf8.encode(data),
              ),
            ],
          ),
        );
      } catch (e) {
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Error"),
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
      leading: const Icon(Icons.save_rounded),
      title: const Text('Backup data'),
      onTap: handleBackupData,
    );
  }
}

Future<String> getAppDataJson() async {
  final db = AppRepo.db;
  final dbActivities = await (db.activityDb.select()).get();
  final dbRecords = await (db.recordDb.select()).get();
  final activities = dbActivities
      .map((a) => Activity(
            id: a.id,
            name: a.name,
            color: a.color,
            emoji: a.emoji,
            createAt: a.createdAt,
            deletedAt: a.deletedAt,
          ))
      .toList();
  final Map<String, List<Record>> recordsMap = {};
  for (var r in dbRecords) {
    if (recordsMap[r.activityId] == null) {
      recordsMap[r.activityId] = [];
    }
    recordsMap[r.activityId]!.add(Record(id: r.id, createAt: r.createdAt));
  }
  final appData = AppData(activities: activities, records: recordsMap);
  return jsonEncode(appData.toJson());
}
