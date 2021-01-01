import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_s/main.dart';
import 'package:permission_handler/permission_handler.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}
 
bool pg = false;

class _Page1State extends State<Page1> {
  @override
  void initState() {
    setState(() {
      permis();
    });
    super.initState();
  }

  void permis() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      await Permission.storage.request().then((value) async {
        status = await Permission.storage.status;
        print(value);
      });
    }
    if (await Permission.storage.isRestricted) {
      await Permission.storage.request();
      setState(() {
        Navigator.of(context).pop();
      });
    }
    if (status.isDenied) {
      setState(() {
        Navigator.of(context).pop();
      });
    }
    if (status.isGranted) {
      print(status.isGranted);
      pg = true;
      setState(() {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (a) => TebBaar()));
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: Center(
        child: FlutterLogo(),
        // child: Image(
        //   image: FlutterLogo(),
        //   fit: BoxFit.contain,
        //   filterQuality: FilterQuality.none,
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        // ),
      ),
    );
  }
}

class Permisionget extends StatefulWidget {
  @override
  _PermisiongetState createState() => _PermisiongetState();
}

class _PermisiongetState extends State<Permisionget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Give Storage Permission"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {},
          child: Text('Get Started'),
        ),
      ),
    );
  }
}
