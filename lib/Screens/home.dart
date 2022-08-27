import 'package:login_assessment/Screens/login.dart';
import 'package:login_assessment/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home'),
            loginBtn(context: context, f: () {
              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
            }, txt: 'Logout')
          ],
        ),
      ),
    );
  }
}
