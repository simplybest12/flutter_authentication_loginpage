import 'package:flutter/material.dart';
import 'package:responsive_login_page/widgets/pallete.dart';

// ignore: must_be_immutable
class LoginField extends StatefulWidget {
  final bool txthide;
  final String hinttxt;
  
  TextEditingController? construct = TextEditingController();

  LoginField(
      {super.key,
      required this.hinttxt,
      required this.txthide,
      this.construct});

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 340,
      child: TextFormField(
      
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
            labelText: widget.hinttxt,
            labelStyle: const TextStyle(color: Colors.white)),
        obscureText: widget.txthide,
      ),
    );
  }
}
