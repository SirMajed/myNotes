import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:my_notes/Screens/AddNoteScreen/AddNoteScreen.dart';
import 'package:my_notes/Screens/ProfileScreen/ProfileScreen.dart';
import 'package:my_notes/Screens/UserNotesScreen/UserNotesScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  List<Widget> screens = [UserNotesScreen(), AddNoteScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MoltenBottomNavigationBar(
        margin: EdgeInsets.all(10),
        barColor: Theme.of(context).primaryColor,
        onTabChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
        domeCircleColor: Theme.of(context).scaffoldBackgroundColor,
        tabs: [
          MoltenTab(
            icon: Icon(FontAwesomeIcons.stickyNote, size: 22),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.white,
          ),
          MoltenTab(
            icon: Icon(FontAwesomeIcons.plus, size: 22),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.white,
          ),
          MoltenTab(
            icon: Icon(FontAwesomeIcons.userAlt, size: 22),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.white,
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
