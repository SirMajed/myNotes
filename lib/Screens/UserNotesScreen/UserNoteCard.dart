import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/Models/Note.dart';
import 'package:expansion_card/expansion_card.dart';

class UserNoteCard extends StatelessWidget {
  final Note note;
  final context;
  ScrollController scollBarController = ScrollController();
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
            height: 135,
            child: Scrollbar(
              thickness: 2.5,
              controller: scollBarController,
              radius: Radius.circular(8),
              showTrackOnHover: true,
              isAlwaysShown: true,
              child: SingleChildScrollView(
                controller: scollBarController,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: AutoSizeText(
                    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes oContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes oContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes oContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Baloo Bhai 2',
                      color: Colors.white,
                    ),
                  ),
                ),
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
