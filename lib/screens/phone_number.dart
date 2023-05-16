import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_login_page/screens/otpverification.dart';
import 'package:responsive_login_page/widgets/gradientbutton.dart';
import 'package:responsive_login_page/widgets/pallete.dart';
import 'package:mobx/mobx.dart';

class Mobile_Number extends StatefulWidget {
  const Mobile_Number({super.key});
  static String verify = "";
  @override
  State<Mobile_Number> createState() => _Mobile_NumberState();
}

class _Mobile_NumberState extends State<Mobile_Number> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationId = Observable('');

  String _phone = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/signin_balls.png'),
            const SizedBox(
              height: 65,
            ),
            const Text(
              "Verify your Mobile No.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 65,
            ),
            SizedBox(
              width: 360,
              child: IntlPhoneField(
                onChanged: (value) {
                  _phone = value.completeNumber;
                  print(_phone);
                },
                initialCountryCode: "IN",
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(28),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Pallete.borderColor, width: 3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Pallete.gradient2, width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Mobile Number",
                    labelStyle: const TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GradientButtonn(
                func: () {
                  verifyUserPhoneNumber();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OTPverifiy(
                            phonew: _phone,
                          )));
                },
                text: "Send OTP")
          ],
        ),
      )),
    );
  }

  // Future<void> verifyOTPCode() async{
  //   PhoneAuthCredential  credential = PhoneAuthProvider.credential(
  //     verificationId: rec,
  //     smsCode: smsCode)
  // }

  void verifyUserPhoneNumber() {
    _auth.verifyPhoneNumber(
      phoneNumber: _phone,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        print(e.message.toString());
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId.value = verificationId;
        Mobile_Number.verify = verificationId;
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
