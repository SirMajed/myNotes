import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_notes/Models/Note.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Screens/UserNotesScreen/GlobalNoteCard.dart';
import 'package:my_notes/Screens/UserNotesScreen/UserNoteCard.dart';
import 'package:my_notes/Services/Database.dart';
import 'package:my_notes/Widgets/MyBar.dart';
import 'package:my_notes/Widgets/MyScaffold.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

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
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 15, bottom: 70),
                    separatorBuilder: (context, _) => Container(
                      height: 30,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: isPublic
                            ? GlobalNoteCard(
                                context: context, note: snapshot.data[index])
                            : UserNoteCard(
                                context: context, note: snapshot.data[index]),
                        secondaryActions: isPublic
                            ? null
                            : <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 7),
                                  child: SlideAction(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.share),
                                        Text('Share'),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.circular(8)),
                                    onTap: () async {
                                      await Share.share(
                                          '${snapshot.data[index].getDescription()}');
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 7),
                                  child: SlideAction(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.delete),
                                        Text('Delete'),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(8)),
                                    onTap: () async {
                                      try {
                                        await Database.deleteNote(
                                            snapshot.data[index]);
                                        MyBar.customFlushBar(
                                            context: context,
                                            message: 'Note deleted',
                                            icon: Icons.check);
                                      } on PlatformException catch (e) {
                                        print(e.toString());
                                      }
                                    },
                                  ),
                                ),
                              ],
                      );
                    },
                  ),
                ),
              );
            else
              return showEmptyNotes(isPublic);
          } else {
            return Expanded(child: Center(child: SpinKitFadingCube(
                    color: Colors.redAccent,
                    size: 20.0,
                  ),));
          }
        },
      ),
    );
  }

  Widget showEmptyNotes(bool isPublic) {
    return Expanded(
      child: Center(
        child: Text(
          isPublic == false
              ? 'You did not wrote any notes yet 😐'
              : 'No one has shared his notes in public yet 😢',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
