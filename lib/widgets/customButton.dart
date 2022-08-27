import 'package:flutter/material.dart';

loginBtn({required context, required f, required txt}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * .6,
      height: MediaQuery.of(context).size.height * .05,
      child: ElevatedButton(
        onPressed: () {
          f();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(txt),
          ],
        ),
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(Colors.grey),
          // backgroundColor: MaterialStateProperty.all(
          //     Color(CustomColors.splashColor))
        ),
      ),
    ),
  );
}
