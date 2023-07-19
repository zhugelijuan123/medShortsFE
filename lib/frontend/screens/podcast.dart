import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';




class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  void playAudio(String url) async{
    await audioPlayer.setUrl(url);
    audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio test'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 16,),
              Flexible(
                child: Text('Play!',
                style: TextStyle(fontSize: 30,),),
              ),
            ],
          ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                              onPressed: () {
                                // Implement signup logic here
                                playAudio('https://www.listennotes.com/e/p/ea09b575d07341599d8d5b71f205517b/');
                                
                              },
                              style: ElevatedButton.styleFrom(
                                      primary: const Color(0xFF414BB2),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              0), // Set the border radius to 0 for right angles
                                        ),
                                      ),
                                      minimumSize: const Size(
                                          double.infinity, 50), // Set the desired height
                                    ),
                              child: const Text(
                                  'go back',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                            ),
                  ),
            ],
          ),
        ]
      ),
    );
  }
}
