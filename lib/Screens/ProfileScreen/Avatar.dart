import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Widgets/MyBar.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;
  final String userID;
  File _imageFile;
  final picker = ImagePicker();
  Avatar({this.imageUrl, this.userID});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          child: imageUrl.contains('firebasestorage')
              ? CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                    ),
                  ),
                  radius: 70,
                )
              : SvgPicture.network(
                  imageUrl,
                  placeholderBuilder: (context) => CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                  
                ),
          radius: 70,
        ),
        Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () async {
              final pickedFile =
                  await picker.getImage(source: ImageSource.gallery);

              if (pickedFile != null) {
                _imageFile = File(pickedFile.path);
                User.uploadFile(_imageFile, userID);
                MyBar.customFlushBar(
                    context: context,
                    message: 'Image updated successfully',
                    icon: Icons.check);
              } else {
                MyBar.customFlushBar(
                    context: context,
                    message: 'You did not select an image',
                    icon: Icons.warning_amber_rounded);
              }
            },
          ),
        ),
      ],
    );
  }
}
