import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final vid;

  const VideoApp({Key key, this.vid}) : super(key: key);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    print('Video file you are looking for:' + widget.vid);
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) setState(() {});
    void _showDialog(context) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Video Saved In Gallery"),
            content: new Text("Succesfully"),
          );
        },
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(' Video'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.download_sharp),
              onPressed: () async {
                GallerySaver.saveVideo(widget.vid, albumName: "Status Saver");
                _showDialog(context);
                print('... . . . . . . . . . . . . . . . . .');
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.shareFiles(['${widget.vid}']);
                },
              ),
            )
          ],
        ),
        body: Center(
          child: Container(
            child: StatusVideo(
              videoPlayerController:
                  VideoPlayerController.file(File(widget.vid.toString())),
              looping: true,
              videoSrc: widget.vid,
            ),
          ),
        ),
      ),
    );
  }
}

class StatusVideo extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final String videoSrc;
  final double aspectRatio;

  StatusVideo({
    @required this.videoPlayerController,
    this.looping,
    this.videoSrc,
    this.aspectRatio,
    Key key,
  }) : super(key: key);

  @override
  _StatusVideoState createState() => new _StatusVideoState();
}

class _StatusVideoState extends State<StatusVideo> {
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        autoInitialize: true,
        looping: widget.looping,
        allowFullScreen: true,
        // aspectRatio: 3 / 2,
        // autoPlay: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(errorMessage),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      body: Container(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
