import 'package:flutter/material.dart';
import 'package:medpulse/backend/services/profile_service.dart';
import 'package:medpulse/frontend/widgets/news_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'introduction_screen.dart';
import 'saved_news.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../constants/constants.dart';


class SavedNewsPage extends StatefulWidget{
  final String selectedLanguage;
  final String acceeToken;

  SavedNewsPage({required this.selectedLanguage, required this.acceeToken});

  @override
  _SavedNewsPageState createState() => _SavedNewsPageState();
}

class _SavedNewsPageState extends State<SavedNewsPage> {
  List<NewsArticle> savedNews = [];
  @override
  void initState(){
    super.initState();
    fetchData();

  }

  Future<dynamic> fetchData() async {
    List<NewsArticle> articleList = await getProfile(widget.acceeToken);
    setState(() {
      savedNews = articleList;
    });
    return articleList;
  }

  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
   
    return Scaffold(
      appBar: AppBar(
          title:Text(
                  'Saved News',
              ),                                      
      ),
      body: Column(
                children: [
              Divider(
                color: Color(0xFFE6E6E6),
                height: 1,
                thickness: 1.5,
              ),    
              SizedBox(height: 9,),
              Expanded(
                child: Container(
                  width:screenSize.width,
                  child: 
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: 
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: savedNews.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: NewsCard(article: savedNews[index], selectedLanguage: widget.selectedLanguage, accessToken: widget.acceeToken, email: 'Logged in',pinIconFlag:false, isPinnedFlag: false,),
                          );
                      },
                    ),
                  )
                ),
              ),
            ],
          ),
    );
    }

  
  
}
