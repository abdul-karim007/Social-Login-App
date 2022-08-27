import 'package:login_assessment/Screens/login.dart';
import 'package:login_assessment/widgets/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  TextEditingController emailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SafeArea(child: SizedBox()),
            Center(
                child: Text(
              'Sign Up',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
              child: Container(
                height: MediaQuery.of(context).size.height * .75,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: customTxtFld('Email', context,
                            Icons.person_outlined, emailcont)),
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                        child: customTxtFld('Password', context,
                            Icons.lock_outlined, passcont)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      height: MediaQuery.of(context).size.height * .05,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: emailcont.text,
                                    password: passcont.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text('Sign Up'),
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    ));
  }
}
