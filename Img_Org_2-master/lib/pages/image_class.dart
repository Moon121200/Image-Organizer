import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'gallery.dart';

// ignore_for_file: prefer_const_constructors
class Imageorganizer extends StatefulWidget {
  const Imageorganizer({Key? key}) : super(key: key);

  @override
  _ImageorganizerState createState() => _ImageorganizerState();
}

class _ImageorganizerState extends State<Imageorganizer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Image Compression")),
      ),
      body: Center(
          child: Text(
        "Please select an image for compression",
        style: TextStyle(fontSize: 20),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final permitted = await PhotoManager.requestPermissionExtend();
          if (!permitted.isAuth) return;
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => Gallery()),
          );
        },
      ),
    );
  }
}
