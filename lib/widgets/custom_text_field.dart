import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
 final TextEditingController? controller;
 final String? labText;
// final TextInputType keyboardType;

  const CustomTextField({
    this.controller,
    this.labText,
   });
  @override
  Widget build(BuildContext context) {
    return TextField(
      //keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'labText'
      ),
    );
  }
}
