import 'package:flutter/material.dart';
import 'package:my_notes/Models/Note.dart';
import 'package:expansion_card/expansion_card.dart';

class UserNoteCard extends StatelessWidget {
  final Note note;
  final context;
  UserNoteCard({this.context, this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ExpansionCard(
        borderRadius: 20,
        background: Image.asset(
          "assets/space.gif",
          fit: BoxFit.cover,
        ),
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${note.getTitle()}",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'BalooBhai',
                ),
              ),
              Text(
                "${note.getReadableDate()}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'BalooBhai',
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "${note.getDescription()}",
              // overflow: TextOverflow.ellipsis,
              // maxLines: 4,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo Bhai 2',
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );

    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 15),
    //   child: Column(
    //     children: [
    //       Container(
    //         padding: EdgeInsets.only(left: 16, right: 16, top: 16),
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.all(
    //             Radius.circular(10),
    //           ),
    //         ),
    //         width: double.infinity,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 Text(
    //                   note.getTitle(),
    //                   style: TextStyle(
    //                       color: Theme.of(context).primaryColor,
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //                 Spacer(),
    //                 Text(
    //                   note.getReadableDate(),
    //                   style: TextStyle(
    //                     color: Colors.grey,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             SizedBox(
    //               height: 15,
    //             ),
    //             Text(
    //               note.getDescription(),
    //               style: TextStyle(
    //                 color: Theme.of(context).primaryColor,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 50,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
