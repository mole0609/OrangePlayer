package com.example.orange_player;

//import androidx.annotation.NonNull;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.webkit.MimeTypeMap;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.PluginRegistry;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;

public class MainActivity extends FlutterActivity {
    private static Context mContext = null;
    private static final String METHOD_CHANNEL = "openFileChannel";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        mContext = this;
        new MethodChannel(getFlutterView(), METHOD_CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {
                    if (methodCall.method.equals("openFile")) {
                        String path = methodCall.argument("path");
                        openFile(mContext, path);
                        result.success("");
                    } else {
                        result.notImplemented();
                    }
                }
        );
    }

    private void openFile(Context context, String path) {
        Log.d("NYDBG", "path = " + path);
        try {
            if (!path.contains("file://")) {
                path = "file://" + path;
            }
            //获取文件类型
            String[] nameType = path.split("\\.");
            String mimeType = MimeTypeMap.getSingleton().getMimeTypeFromExtension(nameType[1]);

            Intent intent = new Intent();
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.setAction(Intent.ACTION_VIEW);
            //设置文件的路径和文件类型
            intent.setDataAndType(Uri.parse(path), mimeType);
            //跳转
            context.startActivity(intent);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}

