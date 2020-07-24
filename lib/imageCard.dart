import 'package:flutter/material.dart';

import 'Photo.dart';
import 'Utility.dart';

class imageCard extends StatelessWidget {

  final Photo photo;
  final Function delete;
  imageCard({this.photo, this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: Column(children: <Widget>[
        Utility.imageFromBase64String(photo.photo_name),
        SizedBox(height: 10),
        FlatButton.icon(
          onPressed: delete,
          icon: Icon(
            Icons.delete,
            color: Colors.redAccent,
          ),
          label: Text(
            'Delete this Image',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
      ),
    );
  }
}
