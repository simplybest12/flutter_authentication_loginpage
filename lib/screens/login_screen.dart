import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_login_page/screens/homescreen.dart';
import 'package:responsive_login_page/screens/phone_number.dart';
import 'package:responsive_login_page/screens/register_screen.dart';
import 'package:responsive_login_page/services/authservices.dart';
import 'package:responsive_login_page/widgets/gradientbutton.dart';
import 'package:responsive_login_page/widgets/pallete.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  bool _isloading = false;
  bool _isload = false;
  final TextEditingController _emailid = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/signin_balls.png'),
                const Text(
                  "Sign In.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                _isload
                    ? const CircularProgressIndicator(
                        color: Colors.purple,
                      )
                    : SocialLoginButton(
                        buttonType: SocialLoginButtonType.google,
                        imageWidth: 25,
                        width: 340,
                        onPressed: () async {
                          setState(() {
                            _isload = true;
                          });
                          User? user = await AuthServices()
                              .signInWithGoogle(context: context);
                          setState(() {
                            _isload = false;
                          });
                          if (user != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          } else {
                            print("unsuccessfull");
                          }
                        },
                        textColor: Colors.white,
                        backgroundColor: Pallete.borderColor,
                        borderRadius: 16,
                      ),

                // const Socialbutton(
                //   iconPath: 'assets/images/gmail.png',
                //   label: "Continue With Google",
                // ),
                const SizedBox(
                  height: 25,
                ),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.facebook,
                  width: 340,
                  imageWidth: 25,
                  onPressed: () {},
                  textColor: Colors.white,
                  backgroundColor: Pallete.borderColor,
                  borderRadius: 16,
                ),

                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "or",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 68,
                  width: 340,
                  child: TextFormField(
                    controller: _emailid,
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
                          borderSide: const BorderSide(
                              color: Pallete.borderColor, width: 3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Pallete.gradient2, width: 3),
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white)),
                    obscureText: true,
                  ),
                ),

                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'reset');
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )),
                const SizedBox(
                  height: 35,
                ),
                _isloading
                    ? const CircularProgressIndicator(
                        color: Colors.purple,
                      )
                    : GradientButtonn(
                        text: "Sign In",
                        func: () async {
                          setState(() {
                            _isloading = true;
                          });
                          if (_emailid.text == "" || _password.text == "") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text("Please enter email Id and password"),
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            User? result = await AuthServices()
                                .login(_emailid.text, _password.text, context);
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
                      ),
                const SizedBox(
                  height: 25,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
                    },
                    child: const Text(
                      "Dont have an accoount?\nGet register with us.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    )),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: Colors.white,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Mobile_Number()));
                    },
                    child: const Text(
                      "Sign in with Mobile number",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
