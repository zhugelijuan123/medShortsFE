import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../constants/constants.dart';
import '../../backend/services/profile_service.dart';
import 'dart:convert';

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

  Map<String, dynamic> toJson(){
      return {
        "title":title,
        "description":description,
        "image":image,
        "author":author,
        "publishdTime":publishdTime,
        "category":category,
        "url":url,  
      };
    }
  
}

class NewsCard extends StatefulWidget {
  final NewsArticle article;
  final String selectedLanguage;
  final String accessToken;
  final String email;
  final bool pinIconFlag;
  bool isPinnedFlag;

  NewsCard({required this.article, required this.selectedLanguage, required this.accessToken, required this.email, required this.pinIconFlag, required this.isPinnedFlag});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  final _scrollController = ScrollController();
  FlutterTts flutterTts = FlutterTts();

  bool isReading = false;

  void readText(String text, String languageCode) async {
    if (isReading){
      await flutterTts.stop();
    }
    else{
      await flutterTts.setLanguage(languageCode);
      await flutterTts.speak(text);
    }
    setState(() {
      isReading = !isReading;
    });
  }

  String getTimeGap(String pubDateString){
    return timeSince(pubDateString);
  }
  
  Future<void> onIconTap(newArticle) async{
    setState(() {
      widget.isPinnedFlag = !widget.isPinnedFlag;
    });
    List<NewsArticle> newsList = await getProfile(widget.accessToken);
    if (widget.isPinnedFlag){
        newsList.add(newArticle);
    } else {
      newsList.removeWhere((element) => newArticle.title == element.title);
    }
    updateProfile(widget.accessToken, newsList);
  }

  double calculateFontSize(double maxWidth, double maxHeight, text){
    double max_height = 2.0;
    var textStyle = TextStyle(height: max_height);

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 6,
    );

    while (textPainter.size.height > maxHeight && max_height > 1.1){
      max_height -= 0.1;
      textStyle = textStyle.copyWith(height: max_height);
      textPainter.text = TextSpan(text:text, style:textStyle);
      textPainter.layout(maxWidth: maxWidth);
    }
    return max_height;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
                color:widget.isPinnedFlag?colorMap['${widget.article.category}']:Color.fromARGB(225, 230, 230, 230),
                height: 1,
                thickness: 1.5,
        ),
        SizedBox(height:6),
        Container(
          color:widget.isPinnedFlag?transColorMap['${widget.article.category}']:Colors.white,
          height:138,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  widget.article.image,
                  width:125,
                  height:143,
                  fit: BoxFit.cover,
                ),
              SizedBox(width: 6,),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 1),
                      Container(
                        height: 110,
                          child: RawScrollbar(
                            thumbVisibility: true,
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              child:  Text(
                                  widget.article.description,
                                  style:TextStyle(fontFamily: 'NotoSans',fontSize: 15,height: 1.3),
                               
                              ),
                            ),
                          ),
                      ),

                      SizedBox(height:1),
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
                              getTimeGap(widget.article.publishdTime),
                              style:TextStyle(fontFamily: 'NotoSans',fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      widget.email != 'Not logged in' && widget.pinIconFlag == true ? InkWell(
                        onTap: () async {
                          await onIconTap(widget.article);
                          },
                        child: Icon(Icons.push_pin_outlined,color: widget.isPinnedFlag?darkerColorMap['${widget.article.category}']:Color.fromARGB(255, 98, 90, 90),)):SizedBox(width:6),
                      SizedBox(width:42),
                      Padding(
                        padding: EdgeInsets.only(right: 12.0), 
                        child:
                          Align(
                            alignment: Alignment.topRight,
                            child: 
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    launchURL('${widget.article.url}'); // Replace with your website URL
                                  },
                                  child: Text(
                                    '...Readmore',
                                    style:TextStyle(fontFamily: 'OpenSans',fontSize: 10, color:Color(0xFF5445FD)),
                                  ),
                                ),
                                SizedBox(width: 6,),                                  
                                InkWell(
                                  onTap: (){
                                    readText(widget.article.description, widget.selectedLanguage);
                                  },
                                  child:isReading?Icon(Icons.stop,size: 18,color: Color.fromARGB(255, 239, 68, 21)):Icon(Icons.volume_up,size: 18,color: Color.fromARGB(255, 127, 125, 121),),
                                ),
                                SizedBox(width:6),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorMap['${widget.article.category}'], // Replace with your desired color
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