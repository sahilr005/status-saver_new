import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_s/video/Videos.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  @override
  _PlayVideoState createState() => _PlayVideoState();
}

final Directory _videoDir =
    new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class _PlayVideoState extends State<PlayVideo> {
  var heigt, weight;
  _getImage(_videoDir) async {
    // await Future.delayed(Duration(milliseconds: 500));
    String thumb = await Thumbnails.getThumbnail(
        videoFile: _videoDir,
        imageType:
            ThumbFormat.PNG, //this image will store in created folderpath
        quality: 10);
    return thumb;
  }

  @override
  Widget build(BuildContext context) {
    heigt = MediaQuery.of(context).size.height;
    weight = MediaQuery.of(context).size.width;
    var videoList = _videoDir
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".mp4"))
        .toList(growable: false);

    return Scaffold(
      backgroundColor: Colors.green[100],
      
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            height: heigt * .6,
            child: FutureBuilder(
              future: _getImage(videoList[index]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Hero(
                      tag: videoList[index],
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (a) => VideoApp(
                                vid: videoList[index],
                              ),
                            ),
                          );
                        },
                        child: Image.file(
                          File(snapshot.data),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                } else {
                  return Hero(
                    tag: videoList[index],
                    child:
                        Container(height: 280.0, child: Text('Wait..........')),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
