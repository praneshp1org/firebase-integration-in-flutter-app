import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onTap}); //constructor modification
  var title;
  final VoidCallback onTap;
  bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: (loading
              ? CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                )
              : Text(title, style: TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}
