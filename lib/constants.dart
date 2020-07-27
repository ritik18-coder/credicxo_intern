import 'package:flutter/material.dart';

BoxDecoration dec =BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomLeft,
        colors: [Colors.deepPurpleAccent[400],Colors.deepPurpleAccent[700],Colors.deepPurple[900]])
);


BoxDecoration dec2 =BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.deepPurpleAccent[400],Colors.deepPurpleAccent[700],Colors.deepPurple[900]])
);