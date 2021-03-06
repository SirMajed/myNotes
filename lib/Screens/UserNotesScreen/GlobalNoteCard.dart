import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_notes/Models/Note.dart';
import 'package:my_notes/Models/User.dart';

class GlobalNoteCard extends StatefulWidget {
  final Note note;
  final context;
  GlobalNoteCard({this.context, this.note});
  @override
  _GlobalNoteCardState createState() => _GlobalNoteCardState();
}

class _GlobalNoteCardState extends State<GlobalNoteCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: User().fetch(widget.note.getUserID()),
        builder: (context, snapshot) {
          User user = snapshot.data;
          if (snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.transparent,
                                child: user.getImage().contains('firebasestorage')
                                    ? CircleAvatar(
                                        backgroundColor: Colors.grey[100],
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                              imageUrl: user.getImage()),
                                        ),
                                        radius: 25,
                                      )
                                    : SvgPicture.network(user.getImage()),
                                radius: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.getName(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    widget.note.getPostDate(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Text(
                          widget.note.getDescription(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        });
  }
}
