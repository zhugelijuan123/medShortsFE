import 'package:flutter/material.dart';
import 'package:medpulse/main.dart';
import 'introduction_screen.dart';


class AudioLanguageScreen extends StatefulWidget{
  String selectedLanguage;
  AudioLanguageScreen({required this.selectedLanguage });

  @override
  _AudioLanguageScreenState createState() => _AudioLanguageScreenState();
}

class _AudioLanguageScreenState extends State<AudioLanguageScreen> {
  
  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, widget.selectedLanguage);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Audio Language')),
        body:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20,),
                Flexible(child: Text('\n\n\n  Choose your prefered audio language and go back to news page!', style: TextStyle(fontSize: 20),)),
              ],
            ),
            SizedBox(height: 20,),
            DropdownButton<String>(
              value: widget.selectedLanguage,
              onChanged: (newValue){
                setState(() {
                  widget.selectedLanguage = newValue!;
                });
              },
              items:[
                DropdownMenuItem(
                  value:'en-US',
                  child: Text('English',style: TextStyle(fontSize: 20),)),
                DropdownMenuItem(
                  value:'es-ES',
                  child: Text('Spanish',style: TextStyle(fontSize: 20))),
                DropdownMenuItem(
                  value:'fr-FR',
                  child: Text('French',style: TextStyle(fontSize: 20))),
                ]),
            SizedBox(height: 10,),
            // ElevatedButton(
            //   onPressed: () {
            //     widget.selectedLanguage = tmpselectedLanguage;
            //   } ,
            //   child:Text('Save your choice'))
          ]),
    ));
  }
}
