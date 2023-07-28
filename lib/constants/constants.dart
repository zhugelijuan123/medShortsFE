import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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


  final Map<String, Color> darkerColorMap = {
    'Medication': Color.fromARGB(255, 223, 169, 88),
    'Mental Health': Color.fromARGB(210, 107, 136, 229),
    'Nutrition': Color.fromARGB(255, 230, 105, 105),
    'Tech': Color.fromARGB(255, 120, 215, 234),
    'Research':Color.fromARGB(255, 232, 127, 98),
    'Environment':Color.fromARGB(255, 152, 216, 87),
  };

  final Map<String, Color> transColorMap = {
    'Medication': Color.fromARGB(255, 244, 226, 198).withOpacity(0.5),
    'Mental Health': Color.fromARGB(210, 216, 224, 251).withOpacity(0.5),
    'Nutrition': Color.fromARGB(255, 249, 231, 231).withOpacity(0.5),
    'Tech': Color.fromARGB(255, 214, 240, 245).withOpacity(0.5),
    'Research':Color.fromARGB(255, 250, 232, 227).withOpacity(0.5),
    'Environment':Color.fromARGB(255, 223, 242, 205).withOpacity(0.5),
  };



  void launchURL(String url) async {
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    // Handle the error gracefully
    print('Error launching URL: $e');
    // Continue with your application flow
    // ...
  }
}


String timeSince(String timeStampString){
  if (timeStampString == null || timeStampString.isEmpty){
    return timeStampString;
  }
  try {
    DateTime timeStamp = DateTime.parse(timeStampString);
    final currentTime = DateTime.now().toUtc();
    final secondsPast = currentTime.difference(timeStamp).inSeconds;

    if(secondsPast < 0){
          print(secondsPast);
          return timeStampString;
    }
    if(secondsPast < 60){
        return '$secondsPast seconds ago';
    }
    if(secondsPast < 3600){
        return '${(secondsPast ~/ 60)} mins ago';
    }
    if(secondsPast <= 86400){
        return '${(secondsPast ~/ 3600)} hours ago';
    }
    if(secondsPast <= 2628000){
        return '${(secondsPast ~/ 86400)} days ago';
    }
    if(secondsPast <= 31536000){
        return '${(secondsPast ~/ 2628000)} months ago';
    }
    if(secondsPast > 31536000){
        return '${(secondsPast ~/ 31536000)} years ago';
    }
    return timeStampString;
  } catch(e){
    return timeStampString;
  }

  

}