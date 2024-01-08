import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/providers/providers.dart';
import 'package:mestorapp/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';


class BackupOption extends StatefulWidget {
  const BackupOption({super.key});

  @override
  State<BackupOption> createState() => _BackupOptionState();
}

class _BackupOptionState extends State<BackupOption> {
  bool _loading = false;

  @override
  Widget build(context) {
    void handleBackupData() async {
      setState(() => _loading = true);
      try {
        final status = await Permission.manageExternalStorage.status;
        if (status != PermissionStatus.granted) {
          final granted = await requestStoragePermission();
          if (!granted) return;
        }
        final data = await getAppDataJson();
        await saveData(data);
        if (!context.mounted) return;
        setState(() => _loading = false);
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Success"),
            content: const Text("Backup saved to Downloads"),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      } catch (e) {
        if (!context.mounted) return;
        setState(() => _loading = false);
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
      leading: const Icon(Icons.file_download),
      title: const Text('Backup data'),
      onTap: _loading ? null : handleBackupData,
    );
  }
}

Future<void> saveData(String data) async {
  const dirPath = '/storage/emulated/0/Download/';
  final now = DateTime.now();
  String fileName =
      'mestor_backup_${now.year}_${now.month}_${now.day}_${now.hour}${now.minute}${now.second}.json';
  final file = File(dirPath + fileName);
  await file.writeAsString(data);
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
