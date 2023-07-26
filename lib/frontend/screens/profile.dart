import 'package:flutter/material.dart';
import 'package:medpulse/main.dart';
import 'introduction_screen.dart';


class ProfileScreen extends StatefulWidget{
  final String email;

  ProfileScreen({required this.email});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Row(
        children: [
          SizedBox(width: 20,),
          Text('\nWelcome! \n ${widget.email}', style: TextStyle(color: Colors.black, fontSize: 20),),
        ],
      ),
      );
  }
}
