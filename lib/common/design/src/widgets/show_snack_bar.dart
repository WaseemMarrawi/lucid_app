import 'package:flutter/material.dart';

class SnackyBar {
  final String messege;
  final Color color;

  SnackyBar({required this.color, required this.messege});

  static SnackBar call(String messege,Color color,Color forecolor) => SnackBar(
    content: Text(messege,style: TextStyle(color: forecolor),),
    backgroundColor: color,

  );
}

//      ScaffoldMessenger.of(context).showSnackBar(
//               SnackyBar.call(state.errorMessage!, Colors.white, Colors.red));