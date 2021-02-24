import 'package:flutter/material.dart';

class MyField extends StatelessWidget {
  final String title;
  final Function onChanged;
  final int maxLines;
  final bool isPassword;
  final IconData icon;
  final String initialValue;
  final TextEditingController controller;
  final Function validator;
  MyField(
      {this.title = '',
      @required this.onChanged,
      this.maxLines = 1,
      this.isPassword = false,
      this.icon,
      this.initialValue,
      this.controller,
      this.validator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (validator != null)
          return validator(val);
        else
          return null;
      },
      controller: controller,
      keyboardType: TextInputType.text,
      enabled: true,
      obscureText: isPassword ? true : false,
      maxLines: maxLines,
      onChanged: (val) {
        if (onChanged != null) onChanged(val);
      },
      initialValue: initialValue,
      decoration: InputDecoration(
        suffixIcon: Icon(icon,),
        contentPadding: EdgeInsets.all(16.0),
        enabled: true,
        fillColor: Theme.of(context).primaryColor,
        filled: true,
        hintText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),

        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      // validator: (String value) {
      //   return value.contains('') ? 'Must not be empty' : null;
      // },
      cursorColor: Colors.white
    );
  }
}
