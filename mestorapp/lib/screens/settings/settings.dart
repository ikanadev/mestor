import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mestorapp/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> downloadData() async {
    Map<String, dynamic> data = {
      'name': 'John Doe',
      'age': 25,
      'city': 'Example City',
    };
    final jsonData = jsonEncode(data);
    String fileName =
        'data_export_${DateTime.now().millisecondsSinceEpoch}.json';
    String filePath = '/storage/emulated/0/Download/$fileName';

    final file = File(filePath);
    await file.writeAsString(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    void handleDownloadData() async {
      try {
        final status = await Permission.manageExternalStorage.status;
        if (status != PermissionStatus.granted) {
          final granted = await requestStoragePermission();
          if (!granted) return;
        }
        await downloadData();
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Success"),
            content: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(text: "Backup file saved in "),
                  TextSpan(
                    text: "Downloads.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
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
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Can't export data"),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.file_download),
            title: const Text('Backup data'),
            onTap: handleDownloadData,
          ),
        ],
      ),
    );
  }
}
