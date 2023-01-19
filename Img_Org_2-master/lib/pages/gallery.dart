import 'package:flutter/material.dart';
import 'package:image_organizer/pages/asset_class.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tflite/tflite.dart';
class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<AssetEntity> assets = [];
  @override
  void initState() {
    _fetchAssets();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4
    ),
    itemCount: assets.length,
    itemBuilder: (_,index){
      return AssetThumbnail(asset: assets[index]);
    }
    ),
    );
  }
  Future loadModel() async {

    Tflite.close();
    await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt");
  }


  _fetchAssets() async {
    // Set onlyAll to true, to fetch only the 'Recent' album
    // which contains all the photos/videos in the storage
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;
    // Now that we got the album, fetch all the assets it contains
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1000000, // end at a very big index (to get all the assets)
    );
    // Update the state and notify UI
    setState(() => assets = recentAssets);
  }
}

