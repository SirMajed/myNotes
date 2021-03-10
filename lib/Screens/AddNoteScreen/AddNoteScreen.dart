import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_notes/Models/Note.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Services/Validations.dart';
import 'package:my_notes/Widgets/MyBar.dart';
import 'package:my_notes/Widgets/MyButton.dart';
import 'package:my_notes/Widgets/MyField.dart';
import 'package:my_notes/Widgets/MyScaffold.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  String title = '';
  String description = '';
  String date = '';
  bool isLoading = false;
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context, listen: false);

    return MyScaffold(
      title: 'Welcome, ${user.getName()} 👋',
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyField(
                onChanged: (val) {
                  title = val;
                },
                icon: Icons.title,
                isPassword: false,
                title: 'Title...',
                maxLines: 1,
                controller: titleController,
                validator: (val) {
                  return Validations.isEmptyValidation(val);
                },
              ),
              SizedBox(
                height: 25,
              ),
              MyField(
                onChanged: (val) {
                  description = val;
                },
                icon: Icons.description,
                isPassword: false,
                title: 'Description...',
                maxLines: 3,
                controller: descriptionController,
                validator: (val) {
                  return Validations.isEmptyValidation(val);
                },
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Publish to public"),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue;
                  });
                },
                activeColor: Colors.redAccent,
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
              SizedBox(
                height: 25,
              ),
              isLoading
                  ? SpinKitFadingCube(
                    color: Colors.redAccent,
                    size: 20.0,
                  )
                  : MyButton(
                      btnText: 'Add note',
                      function: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            Note note = Note(
                              date: DateTime.now().toString(),
                              title: title,
                              description: description,
                              userID: user.getID(),
                            );
                            await user.addNote(note, checkedValue);
                            clearField();
                            MyBar.customFlushBar(
                                context: context,
                                message: 'Note Added',
                                icon: Icons.check);
                          } on PlatformException catch (e) {
                            print(e.toString());
                          }
                        }
                        setState(() {
                          isLoading = false;
                          _autoValidate = true;
                          checkedValue = false;
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void clearField() {
    titleController.clear();
    descriptionController.clear();
  }
}
