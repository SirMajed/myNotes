import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';
import 'package:my_notes/Models/Note.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Services/Database.dart';
import 'package:my_notes/Widgets/MyScaffold.dart';
import 'package:provider/provider.dart';

class UserNotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context, listen: false);

    return MyScaffold(
      title: 'My Notes',
      body: StreamBuilder<List<Note>>(
        stream: Database.getNotes(user.getID()),
        builder: (context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0)
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 15, bottom: 70),
                    separatorBuilder: (context, _) => Container(
                      height: 30,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return noteCard(context, snapshot.data[index]);
                    },
                  ),
                ),
              );
            else
              return showEmptyHistory();
          } else {
            return Expanded(child: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }

  Widget showEmptyHistory() {
    return Expanded(
      child: Center(
        child: Text(
          'There are no orders in your history',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget noteCard(context, Note note) {
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
              BotToast.showSimpleNotification(
                title: 'Note deleted',
                backgroundColor: Colors.redAccent,
                closeIcon: Icon(Icons.check),
                align: Alignment.bottomCenter,
                borderRadius: 8,
                hideCloseButton: false,
              );
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
                          color: Theme.of(context).primaryColor,
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
