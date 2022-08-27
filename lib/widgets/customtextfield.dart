import 'package:flutter/material.dart';

customTxtFld(textFieldText, context, icon1, txtcont) {
  return SizedBox(
      // width: MediaQuery.of(context).size.width * .8,
      child: TextField(
    controller: txtcont,
    decoration: InputDecoration(
        prefixIcon: Icon(icon1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
        hintText: textFieldText,
        ),
  ));
}