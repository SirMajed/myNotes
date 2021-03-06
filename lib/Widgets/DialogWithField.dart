import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogWithField {
  final String positiveActionText;
  final Function positiveAction;
  final String negativeActionText;
  final Function negativeAction;
  final String currentName;
  final String title;
  final String hint;
  final Function onChanged;
  final bool isPassword;
  bool _loading = false;
  DialogWithField(
      {this.title,
      this.positiveActionText,
      this.positiveAction,
      this.currentName,
      this.hint,
      this.onChanged,
      this.negativeAction,
      this.negativeActionText,
      this.isPassword = false});

  displayDialog(BuildContext context) {
    return showDialog(
      barrierColor: Colors.redAccent.withOpacity(0.1),
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        insetPadding: EdgeInsets.all(15),
        backgroundColor: Colors.transparent,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).primaryColor),
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (val) => onChanged(val),
                initialValue: currentName,
                obscureText: isPassword ? true : false,
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: hint,
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    child: new Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  _loading
                      ? SpinKitFadingCube(
                    color: Colors.redAccent,
                    size: 20.0,
                  )
                      : FlatButton(
                          child: new Text(
                            positiveActionText,
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          onPressed: () {
                            return positiveAction();
                          },
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // confirmationDialog(BuildContext context) {
  //   return showDialog(
  //     barrierColor: Colors.redAccent.withOpacity(0.1),
  //     context: context,
  //     builder: (context) => Dialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //       insetPadding: EdgeInsets.all(15),
  //       backgroundColor: Colors.transparent,
  //       child: Stack(
  //         overflow: Overflow.visible,
  //         alignment: Alignment.center,
  //         children: <Widget>[
  //           Container(
  //             width: double.infinity,
  //             height: 120,
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(15),
  //                 color: Theme.of(context).primaryColor),
  //             padding: EdgeInsets.all(12),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: TextStyle(fontSize: 16, color: Colors.redAccent),
  //                 ),

  //                 // SizedBox(
  //                 //   height: 15,
  //                 // ),
  //                 // TextFormField(
  //                 //   onChanged: (val) => onChanged(val),
  //                 //   initialValue: currentName,
  //                 //   textInputAction: TextInputAction.go,
  //                 //   keyboardType: TextInputType.text,
  //                 //   decoration: InputDecoration(
  //                 //       enabledBorder: UnderlineInputBorder(
  //                 //         borderSide: BorderSide(color: Colors.white),
  //                 //       ),
  //                 //       focusedBorder: UnderlineInputBorder(
  //                 //         borderSide: BorderSide(color: Colors.white),
  //                 //       ),
  //                 //       hintText: hint,
  //                 //       labelStyle: TextStyle(color: Colors.white),
  //                 //       hintStyle: TextStyle(color: Colors.white),
  //                 //       fillColor: Colors.white),
  //                 // ),
  //                 Spacer(),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     TextButton(
  //                       onPressed: () {
  //                         return negativeAction();
  //                       },
  //                       child: new Text(
  //                         negativeActionText,
  //                         style: TextStyle(color: Colors.white),
  //                       ),
  //                     ),
  //                     TextButton(
  //                       onPressed: () {
  //                         return positiveAction();
  //                       },
  //                       child: Text(
  //                         positiveActionText,
  //                         style: TextStyle(color: Colors.redAccent),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           // Positioned(
  //           //   top: -100,
  //           //   child: SvgPicture.asset('assets/note.svg'),
  //           //   height: 150,
  //           //   width: 150,
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
