import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStoragePermission() async {
  if (!Platform.isAndroid) {
    throw Exception("Export data only available in Android devices");
  }
  final status = await Permission.storage.status;
  // if (status == PermissionStatus.granted) return true;
  if (status == PermissionStatus.permanentlyDenied) {
    throw Exception(
      "Permission permanently denied, grant storage permissions in Settings",
    );
  }
  final result = await Permission.manageExternalStorage.request();
  return result == PermissionStatus.granted;
}
