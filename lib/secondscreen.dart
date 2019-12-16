import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SecondScreen extends StatefulWidget {
  File _file;

  SecondScreen(File file) {
    _file = file;
  }

  @override
  _SecondScreenState createState() => _SecondScreenState(_file);
}

class _SecondScreenState extends State<SecondScreen> {
  VideoPlayerController _controller;
  String path;
  File _file;

  _SecondScreenState(File file) {
    _file = file;
  }

  @override
  void initState() {
    if (_file != null) {
      print('NYDBG file.path = $_file');
      _controller = VideoPlayerController.file(_file)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(
                    child: Text("22222"),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
