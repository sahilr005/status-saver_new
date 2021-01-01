import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class FullPhoto extends StatefulWidget {
  final img;
  final path;
  const FullPhoto({Key key, this.img, this.path}) : super(key: key);
  @override
  _FullPhotoState createState() => _FullPhotoState();
}

class _FullPhotoState extends State<FullPhoto> {
  void _showDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Photo Saved In Gallery"),
          content: new Text("Succesfully"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Full Photo'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.shareFiles(['${widget.img}']);
              },
            ),
          )
        ],
      ),
      backgroundColor: Colors.teal[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GallerySaver.saveImage(widget.img);
          _showDialog(context);
          print('... . . . . . . . . . . . . . . . . .');
        },
        child: Icon(Icons.download_sharp),
      ),
      body: Center(
        child: Image.file(
          File(widget.img),
          // fit: BoxFit.fill,
        ),
      ),
    );
  }
}
