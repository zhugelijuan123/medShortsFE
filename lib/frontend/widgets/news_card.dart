import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:google_fonts/google_fonts.dart';


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

class NewsCard extends StatelessWidget {
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                  article.image,
                  width:150,
                  height:150,
                  fit: BoxFit.cover,
                ),
              SizedBox(width: 10,),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        article.description,
                        style:TextStyle(fontFamily: 'NotoSans',fontSize: 16),
                      ),
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
                              '${article.publishdTime}',
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
                                    launchURL('${article.url}'); // Replace with your website URL
                                  },
                                  child: Text(
                                    '...Readmore',
                                    style:TextStyle(fontFamily: 'OpenSans',fontSize: 10, color:Color(0xFF5445FD)),
                                  ),
                                ),
                                SizedBox(width: 3,),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorMap['${article.category}'], // Replace with your desired color
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