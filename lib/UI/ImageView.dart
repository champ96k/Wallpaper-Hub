
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_in_gallery/save_in_gallery.dart';
import 'package:image_downloader/image_downloader.dart';


class ImageView extends StatefulWidget {
  final imageURl;
  ImageView(this.imageURl);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return widget.imageURl != null
        ? Hero(
            tag: widget.imageURl,
            child: Scaffold(
              body: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                      imageUrl: widget.imageURl, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 42.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomCenter,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                            save();
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xff1C1B1B).withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white24, width: 1),
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: LinearGradient(
                                          colors: [
                                            Color(0x36FFFFFF),
                                            Color(0x0FFFFFFF)
                                          ],
                                          begin: FractionalOffset.topLeft,
                                          end: FractionalOffset.bottomRight)),
                                  child: Text(
                                    "Set Wallpaper",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    )),
              ]),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }


  save() async {
    try {
      var imageId = await ImageDownloader.downloadImage(widget.imageURl);
       print("imageId: $imageId");
       print("widget.imageURl: ${widget.imageURl}");
       Navigator.pop(context);
  if (imageId == null) {
    print("Download image");
    return;
  }
    } catch (e) {
      print(e.toString());
    }
  }

  
}
