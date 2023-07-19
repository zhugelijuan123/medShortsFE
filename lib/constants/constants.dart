import 'package:flutter/material.dart';

final List<String> imagePaths = [
    'assets/images/medication.png',
    'assets/images/mental_health_ori.png',
    'assets/images/nutrition.png',
    'assets/images/tech_2.png',
    'assets/images/research.png',
    'assets/images/environment.jpeg',
  ];

  final List<String> categoryNames = [
      'Medication',
      'Mental Health',
      'Nutrition',
      'Tech',
      'Research',
      'Environment',
  ];

  final List<Color> backgroundColors = [
    Color.fromARGB(255, 250, 236, 219),
    Color.fromARGB(210, 233, 238, 255),
    Color.fromARGB(255, 249, 231, 231),
    Color.fromARGB(255, 216, 238, 244),
    Color.fromARGB(255, 249, 238, 235),
    Color.fromARGB(255, 240, 250, 230),
  ];


  final Map<String, Color> colorMap = {
    'Medication': Color.fromARGB(255, 244, 219, 181),
    'Mental Health': Color.fromARGB(210, 216, 224, 251),
    'Nutrition': Color.fromARGB(255, 249, 231, 231),
    'Tech': Color.fromARGB(255, 192, 229, 236),
    'Research':Color.fromARGB(255, 250, 232, 227),
    'Environment':Color.fromARGB(255, 205, 244, 165),
  };