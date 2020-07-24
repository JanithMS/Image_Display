import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Utility.dart';
import 'DBHelper.dart';
import 'Photo.dart';
import 'dart:async';

import 'imageCard.dart';

void main() {
  runApp(MaterialApp(
    home: SaveImage(),
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
  ));
}

class SaveImage extends StatefulWidget {

  SaveImage() : super();

  final String title = "Flutter Save Image";

  @override
  _SaveImageState createState() => _SaveImageState();
}

class _SaveImageState extends State<SaveImage> {

  Future<File> imageFile;
  Image image;
  DBHelper dbHelper;
  List<Photo> images;

  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = DBHelper();
    refreshImages();
  }

  refreshImages() {
    dbHelper.getPhotos().then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  pickImageFromGallery() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      String imgString = Utility.base64String(imgFile.readAsBytesSync());
      Photo photo = Photo(0, imgString);
      dbHelper.save(photo);
      refreshImages();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IMAGES',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: images.map((photo) => imageCard(
          photo: photo,
          delete: () {
              dbHelper.delete(photo.photo_name);
              refreshImages();
          },
        )).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          pickImageFromGallery();
        },
        icon: Icon(Icons.add_a_photo),
        label: Text('Save Image'),
        foregroundColor: Colors.white,
      ),
    );
  }
}