import 'package:flutter/material.dart';
import 'package:my_notes/Models/Note.dart';
import 'package:my_notes/Services/Database.dart';
import 'package:my_notes/Widgets/MyBar.dart';
class UserNoteCard extends StatelessWidget {
  final Note note;
  final context;
  UserNoteCard({this.context, this.note});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Dismissible(
            background: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ],
            ),
            onResize: () {
              MyBar.customFlushBar(
                                        context: context,
                                        message: 'Note deleted',
                                        icon: Icons.check);
            },
            key: Key(note.getDate()),
            onDismissed: (direction) async {
              await Database.deleteNote(note);
            },
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        note.getTitle(),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        note.getReadableDate(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    note.getDescription(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
