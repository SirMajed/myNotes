import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notes/Models/User.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;
  final String userID;
   File _imageFile;
  final picker = ImagePicker();
  Avatar({this.imageUrl, this.userID});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        AvatarGlow(
          glowColor: Colors.redAccent,
          endRadius: 90,
          child: Material(
            elevation: 8.0,
            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundColor: Colors.grey[100],
              child: ClipOval(
                child: CachedNetworkImage(imageUrl: imageUrl ),
              ),
              radius: 70,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: () async {
            final pickedFile =
                await picker.getImage(source: ImageSource.gallery);

            if (pickedFile != null) {
              _imageFile = File(pickedFile.path);
              User.uploadFile(_imageFile, userID);
              BotToast.showSimpleNotification(
                title: 'Image updated successfully',
                backgroundColor: Colors.redAccent,
                closeIcon: Icon(Icons.warning_amber_rounded),
                align: Alignment.bottomCenter,
                borderRadius: 8,
                hideCloseButton: false,
              );
            } else {
              BotToast.showSimpleNotification(
                title: 'You did not select an image',
                backgroundColor: Colors.redAccent,
                closeIcon: Icon(Icons.warning_amber_rounded),
                align: Alignment.bottomCenter,
                borderRadius: 8,
                hideCloseButton: false,
              );
            }
          },
        ),
      ],
    );
  }
}
