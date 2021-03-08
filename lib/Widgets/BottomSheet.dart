import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/Widgets/MyButton.dart';
import 'package:my_notes/Widgets/MyField.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class SlidingBottom {
  static String email = '';
  static void showAsBottomSheet({
    BuildContext context,
    Function btnFunction,
  }) async {
    bool loading = false;
    await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        backdropColor: Colors.redAccent.withOpacity(0.2),
        color: Colors.white,
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) {
          return StatefulBuilder(
            builder: (context, setState) => Container(
              height: 400,
              child: Center(
                child: Material(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('Reset Password',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: MyField.myField2(
                              context: context,
                              function: (val) {
                                email = val;
                                print(email);
                              },
                              hint: 'Enter your email...'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: loading
                              ? CircularProgressIndicator()
                              : MyButton(
                                  btnText: 'Reset Password',
                                  function: () async{
                                    setState(() {
                                      loading = true;
                                    });
                                     await btnFunction(email);
                                    setState(() {
                                      loading = false;
                                    });

                                  },
                                  borderColor: Theme.of(context).primaryColor,
                                  textColor: Colors.redAccent,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
