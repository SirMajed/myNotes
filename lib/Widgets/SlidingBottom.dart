import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_notes/Services/Validations.dart';
import 'package:my_notes/Widgets/MyButton.dart';
import 'package:my_notes/Widgets/MyField.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class SlidingBottom {
  static String userInput = '';
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static void showAsBottomSheet({
    BuildContext context,
    Function btnFunction,
    String title,
    String textFieldHint,
    String buttonText,
    bool emailValidation = false,
    bool passwordValidation = false,
    bool isPassword = false,
    String currentText = '',
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
                        Text(
                          title,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Form(
                            key: formKey,
                            child: MyField.myField2(
                              isPasword: isPassword,
                              context: context,
                              function: (val) {
                                userInput = val;
                              },
                              hint: textFieldHint,
                              initialValue: currentText,
                              validator: (val) {
                                if (emailValidation == true) {
                                  return Validations.emailValidation(val);
                                } else if (passwordValidation == true) {
                                  return Validations.passwordValidation(val);
                                } else
                                  return Validations.isEmptyValidation(val);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: loading
                              ? SpinKitFadingCube(
                                  color: Colors.redAccent,
                                  size: 20.0,
                                )
                              : MyButton(
                                  btnText: buttonText,
                                  function: () async {
                                    if (formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      await btnFunction(userInput);
                                    }

                                    setState(() {
                                      loading = false;
                                    });
                                    //Navigator.pop(context);
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
