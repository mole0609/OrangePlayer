import 'dart:io';
import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:orange_player/file_manager.dart';
import 'package:orange_player/secondscreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:orange_player/common.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Future<void> getSDCardDir() async {
    Common().sDCardDir = (await getExternalStorageDirectory()).path;
  }

  // Permission check
  Future<void> getPermission() async {
    if (Platform.isAndroid) {
      PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      }
      await getSDCardDir();
    } else if (Platform.isIOS) {
      await getSDCardDir();
    }
  }

  Future.wait([initializeDateFormatting("zh_CN", null), getPermission()]).then((result) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FileManager(),
    );
  }
}
