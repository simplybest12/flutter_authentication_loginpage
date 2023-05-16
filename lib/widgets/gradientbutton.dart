import 'package:flutter/material.dart';
import 'package:responsive_login_page/widgets/pallete.dart';

class GradientButtonn extends StatefulWidget {
  final String text;
  final Function? func;
  const GradientButtonn({super.key, required this.func, required this.text});

  @override
  State<GradientButtonn> createState() => _GradientButtonnState();
}

class _GradientButtonnState extends State<GradientButtonn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Pallete.gradient1, Pallete.gradient2, Pallete.gradient3],
          ),
          borderRadius: BorderRadius.circular(12)),
      child: TextButton(
        style: TextButton.styleFrom(
          fixedSize: const Size(340, 55),
        ),
        onPressed: () {
          widget.func!();
        },
        child: Text(
          widget.text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
