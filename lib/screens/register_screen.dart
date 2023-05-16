import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_login_page/screens/homescreen.dart';
import 'package:responsive_login_page/widgets/gradientbutton.dart';
import 'package:responsive_login_page/widgets/pallete.dart';

import '../services/authservices.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isloading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/signin_balls.png'),
            const Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            SizedBox(
              height: 68,
              width: 340,
              child: TextFormField(
                controller: _email,
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
                    labelText: "Email Id",
                    labelStyle: const TextStyle(color: Colors.white)),
                obscureText: false,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 68,
              width: 340,
              child: TextFormField(
                controller: _password,
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
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.white)),
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 68,
              width: 340,
              child: TextFormField(
                controller: _confirmpassword,
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
                    labelText: "Confirm Password",
                    labelStyle: const TextStyle(color: Colors.white)),
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            _isloading
                ? const CircularProgressIndicator(
                    color: Colors.purple,
                  )
                : GradientButtonn(
                    func: () async {
                      setState(() {
                        _isloading = true;
                      });
                      if (_email.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("All Fields are required!"),
                          backgroundColor: Colors.red,
                        ));
                      } else if (_password.text != _confirmpassword.text) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Passwords are not same"),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        User? result = await AuthServices()
                            .register(_email.text, _password.text, context);
                        if (result != null) {
                          print("Success");
                          print(result.email);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (route) => false);
                        }
                      }
                      setState(() {
                        _isloading = false;
                      });
                    },
                    text: "Sign Up")
          ],
        ),
      )),
    );
  }
}
