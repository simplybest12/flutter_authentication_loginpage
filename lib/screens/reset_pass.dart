import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_login_page/widgets/gradientbutton.dart';
import 'package:mobx/mobx.dart';
import 'package:responsive_login_page/widgets/pallete.dart';

import 'otpverification.dart';

class ResetPassword extends StatefulWidget {
  static String verify = "";
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final String IN = "+91";
  var verificationId = Observable('');
  bool _isload = false;
  TextEditingController email = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/signin_balls.png'),
            const SizedBox(
              height: 65,
            ),
            const Text(
              "Reset Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(28),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Pallete.borderColor, width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Pallete.gradient2, width: 3),
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "Write your email or phone number",
                  labelStyle: const TextStyle(color: Colors.white)),
              obscureText: false,
            ),
            SizedBox(
              height: 45,
            ),
            _isload
                ? CircularProgressIndicator(
                    color: Colors.purple,
                  )
                : GradientButtonn(
                    func: () async {
                      setState(() {
                        _isload = true;
                      });
                      if (email.text.contains('@gmail.com')) {
                        if (email.text == "") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please enter your registered email"),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          try {
                            await auth.sendPasswordResetEmail(
                                email: email.text);
                          } catch (e) {
                            print("unsuccessful");
                            print(e);
                          }
                        }
                      } else {
                        verifyUserPhoneNumber();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OTPverifiy(
                                  phonew: email.text,
                                )));
                      }

                      setState(() {
                        _isload = false;
                      });
                    },
                    text: "Tap to reset")
          ],
        ),
      ),
    );
  }

  void verifyUserPhoneNumber() {
    auth.verifyPhoneNumber(
      phoneNumber: IN + email.text,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        print(e.message.toString());
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId.value = verificationId;
        ResetPassword.verify = verificationId;
        Navigator.pushNamed(context, "otp");
        print("Code sent");
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId.value = verificationId;
        print("Timed Out");
      },
    );
  }
}
