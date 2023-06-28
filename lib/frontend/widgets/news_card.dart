import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';


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


class NewsArticle {
  final String title;
  final String description;
  final String image;
  final String author;
  final String publishdTime;
  final String category;
  final String url;

  NewsArticle({
    required this.title,
    required this.description,
    required this.image,
    required this.author,
    required this.publishdTime,
    required this.category,
    required this.url,
  });
}

class NewsCard extends StatefulWidget {
  final NewsArticle article;


  static final Map<String, Color> colorMap = {
    'Tech': Color.fromARGB(255, 208, 242, 171),
    'Medication': Color.fromARGB(255, 244, 219, 181),
    'Research':Color.fromARGB(255, 228, 162, 162),
    'Mental Health': Color.fromARGB(255, 167, 185, 234),
    'Nutrition': Color.fromARGB(255, 231, 159, 159),
    'Environment':Color.fromARGB(255, 205, 244, 165),
  };

  const NewsCard({required this.article});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  final _scrollController = ScrollController();
  FlutterTts flutterTts = FlutterTts();
  bool isReading = false;

  void readText(String text) async {
    if (isReading){
      await flutterTts.stop();
    }
    else{
      await flutterTts.speak(text);
    }
    setState(() {
      isReading = !isReading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
                color: Color(0xFFE6E6E6),
                height: 1,
                thickness: 1.5,
        ),
        SizedBox(height:6),
        Container(
          // height:190,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                  widget.article.image,
                  width:130,
                  height:146,
                  fit: BoxFit.cover,
                ),
              SizedBox(width: 10,),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        height: 140,
                          child: RawScrollbar(
                            thumbVisibility: true,
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              child: Container(
                                child: Text(
                                  widget.article.description,
                                  style:TextStyle(fontFamily: 'NotoSans',fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                      ),
                      SizedBox(height:10),
                      Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Baseline(
                            baselineType: TextBaseline.alphabetic,
                            baseline: 6.0,
                            child: 
                            Text(
                              '${widget.article.publishdTime}',
                              style:TextStyle(fontFamily: 'NotoSans',fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 7.0), 
                        child:
                          Align(
                            alignment: Alignment.topRight,
                            child: 
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    launchURL('${widget.article.url}'); // Replace with your website URL
                                  },
                                  child: Text(
                                    '...Readmore',
                                    style:TextStyle(fontFamily: 'OpenSans',fontSize: 10, color:Color(0xFF5445FD)),
                                  ),
                                ),
                                SizedBox(width: 3,),
                                InkWell(
                                  onTap: (){
                                    readText(widget.article.description);
                                  },
                                  child:isReading?Icon(Icons.stop,size: 18,color: Color.fromARGB(255, 239, 68, 21)):Icon(Icons.volume_up,size: 18,color: Color.fromARGB(255, 127, 125, 121),),
                                ),
                                SizedBox(width:6),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: NewsCard.colorMap['${widget.article.category}'], // Replace with your desired color
                                  ),
                                ),
                              ],
                            )
                          ), 
                      ),
                    ],
                  ), 
                    ],
                  ),
              ),
            ],
          ),
        ),
        SizedBox(height:6),
        Divider(
                      color: Color(0xFFE6E6E6),
                      height: 1,
                      thickness: 1.5,
        ),
      ],
    );
  }
}