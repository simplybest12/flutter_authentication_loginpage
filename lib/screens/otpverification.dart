import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_login_page/screens/homescreen.dart';
import 'package:responsive_login_page/screens/phone_number.dart';
import 'package:responsive_login_page/widgets/gradientbutton.dart';
import 'package:responsive_login_page/widgets/pallete.dart';

// ignore: must_be_immutable
class OTPverifiy extends StatefulWidget {
  OTPverifiy({super.key, required this.phonew});
  String phonew;

  @override
  State<OTPverifiy> createState() => _OTPverifiyState();
}

class _OTPverifiyState extends State<OTPverifiy> {
  String smscoder = "";
  FirebaseAuth auth = FirebaseAuth.instance;
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
              height: 35,
            ),
            const Text(
              "Verification",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "OTP had been sent to \n${widget.phonew.replaceRange(0, 9, '********')}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 300,
              child: Pinput(
                onChanged: (value) {
                  smscoder = value;
                  print(smscoder);
                },
                length: 6,
                obscureText: true,
                defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle:
                        const TextStyle(fontSize: 25, color: Colors.white),
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        border: Border.all(
                          color: (const Color.fromRGBO(17, 138, 237, 1)),
                        ),
                        borderRadius: BorderRadius.circular(16))),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Edit Phone number?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            GradientButtonn(
                func: () async {
                  try {
                    String code = smscoder;
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: Mobile_Number.verify,
                            smsCode: code);
                    await auth.signInWithCredential(credential);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: ((context) => HomeScreen())),
                        (route) => false);
                    print(Mobile_Number.verify);
                  } catch (e) {
                    print(Mobile_Number.verify);
                    print(e);
                    print("Cant do yjis");
                    //  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                    //       content: Text(e.toString()),
                    //       backgroundColor: Colors.red,
                    //     ));
                  }
                },
                text: "Verify"),
          ],
        ),
      )),
    );
  }
}
