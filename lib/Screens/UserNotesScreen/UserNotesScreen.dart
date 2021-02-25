import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';
import 'package:my_notes/Models/Note.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Screens/UserNotesScreen/GlobalNoteCard.dart';
import 'package:my_notes/Screens/UserNotesScreen/UserNoteCard.dart';
import 'package:my_notes/Services/Database.dart';
import 'package:my_notes/Widgets/MyScaffold.dart';
import 'package:provider/provider.dart';

class UserNotesScreen extends StatefulWidget {
  @override
  _UserNotesScreenState createState() => _UserNotesScreenState();
}

class _UserNotesScreenState extends State<UserNotesScreen> {
  bool isPublic = false;
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context, listen: false);
    return MyScaffold(
      hasButton: true,
      globalNotes: () {
        setState(() {
          isPublic = true;
        });
      },
      currentUserNotes: () {
        setState(() {
          isPublic = false;
        });
      },
      title: isPublic ? 'Public Notes' : 'My Notes',
      body: StreamBuilder<List<Note>>(
        stream: Database.getNotes(user.getID(), isPublic),
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
                      return isPublic
                          ? GlobalNoteCard(
                              context: context, note: snapshot.data[index])
                          : UserNoteCard(
                              context: context, note: snapshot.data[index]);
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
}
