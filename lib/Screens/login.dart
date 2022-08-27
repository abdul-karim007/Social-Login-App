import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:login_assessment/Screens/SignUp.dart';
import 'package:login_assessment/Screens/home.dart';
import 'package:login_assessment/widgets/customButton.dart';
import 'package:login_assessment/widgets/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatelessWidget {
  TextEditingController emailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SafeArea(child: SizedBox()),
                Center(
                    child: Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                )),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .2),
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
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15),
                            child: customTxtFld('Password', context,
                                Icons.lock_outlined, passcont)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          height: MediaQuery.of(context).size.height * .05,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: emailcont.text,
                                            password: passcont.text);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('user-not-found');
                                } else if (e.code == 'wrong-password') {
                                  print('Wrong pass');
                                }
                              }
                            },
                            child: Text('Login'),
                            style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'or',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SignInButton(
                          Buttons.Google,
                          onPressed: () async {
                            final GoogleSignInAccount? googleUser =
                                await GoogleSignIn().signIn();
                            final GoogleSignInAuthentication? googleAuth =
                                await googleUser?.authentication;
                            final credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth?.accessToken,
                              idToken: googleAuth?.idToken,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                            return await FirebaseAuth.instance
                                .signInWithCredential(credential);
                          },
                        ),
                        SignInButton(
                          Buttons.Facebook,
                          onPressed: () {
                            signInWithFacebook(context);
                          },
                        ),
                        SignInButton(Buttons.Apple, onPressed: () {}),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()),
                                );
                              },
                              child: Text(
                                'Create Account',
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
        ));
  }

  void signInWithFacebook(context) async {
    try {
      final LoginResult result = await FacebookAuth.instance
          .login(permissions: (['email', 'public_profile']));
      final token = result.accessToken!.token;
      print(
          'Facebook token userID : ${result.accessToken!.grantedPermissions}');
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/'
          'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));

      final profile = jsonDecode(graphResponse.body);
      print("Profile is equal to $profile");
      try {
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } catch (e) {
        final snackBar = SnackBar(
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString()),
          backgroundColor: (Colors.redAccent),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print("error occurred");
      print(e.toString());
    }
  }

  // signInWithFacebook(context)
}
