import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_s/Fullphoto.dart';
import 'package:new_s/p1.dart';
import 'package:new_s/video/playVideo.dart';
import 'package:permission_handler/permission_handler.dart';


void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Player Demo',
      home: pg == true ? TebBaar() : Page1(),
      // home: TebBaar(),
    );
  }
}

class TebBaar extends StatefulWidget {
  @override
  _TebBaarState createState() => _TebBaarState();
}

class _TebBaarState extends State<TebBaar> {
  var currentindex = 0;
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  var tab = [
    Images(),
    PlayVideo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("Status Saver"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        selectedFontSize: 19.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: "Photos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library), label: "Videos")
        ],
      ),
      body: tab[currentindex],
    );
  }
}

class Images extends StatefulWidget {
  @override
  _ImagesState createState() => _ImagesState();
}

Directory directory = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class _ImagesState extends State<Images> {
  var imageList = directory
      .listSync()
      .map((item) => item.path)
      .where((item) => item.endsWith(".jpg"))
      .toList(growable: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          print(imageList.length);
          String imgPath = imageList[index];
          if (imageList.length > 0) {
            return Container(
              margin: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  print(imgPath[index]);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (a) => FullPhoto(
                            img: imgPath,
                            path: imgPath,
                          )));
                },
                child: Image.file(
                  File(imgPath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
          ;
        },
      ),
    );
  }
}
