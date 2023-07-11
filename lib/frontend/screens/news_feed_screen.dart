import 'package:flutter/material.dart';
import 'package:medpulse/frontend/widgets/news_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<NewsArticle> extractArticle(String jsonString) {
  List<NewsArticle> articleList = [];
  dynamic jsonData = json.decode(jsonString);

  articleList = jsonData.map((jsonObject){
    return NewsArticle(title: jsonObject['title'], description: jsonObject['description'], image: '', author: 'assets/images/mountain.jpeg', publishdTime: '23 mins', category: 'Medication', url: jsonObject['url']);
  }).toList();

  return articleList;

}

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
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

  List<String> selectedCategories = ['Medication'];
  dynamic jsonResponse;
  final PageController _pageController = PageController();


  Future<dynamic> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:8080/fetchnews/'));
    if (response.statusCode == 200){
      final data = response.body;
      jsonResponse = json.decode(data);
      return jsonResponse;
    } else{
      print('Error: ${response.statusCode}');
      return [];
    }
  }

  List<NewsArticle> getSelectedNewsArticles() {
    List<NewsArticle> newsArticles = [];
    if (selectedCategories.length == 0 || selectedCategories.length == categoryNames.length){
      dynamic js = jsonResponse['articles'][selectedCategories[0]];
      for (int idx = 0;idx<js.length;idx++){
        dynamic jsonObject = js[idx];
        if (jsonObject['summary'] != null && jsonObject['publishedTimeGap'] != null && jsonObject['imageUrl'] != null && jsonObject['url'] != null && jsonObject['summary'] != '' && jsonObject['publishedTimeGap'] != '' && jsonObject['imageUrl'] != '' && jsonObject['url'] != '' ){
          newsArticles.add(NewsArticle(
            title: jsonObject['title'], 
            description: jsonObject['summary'], 
            image: jsonObject['imageUrl'], 
            author: 'lijuan', 
            publishdTime: jsonObject['publishedTimeGap'], 
            category: selectedCategories[0], 
            url: jsonObject['url']));
        }
      }
      return newsArticles;
    }
    else{
      dynamic js = jsonResponse['articles'][selectedCategories[0]];
      for (int idx = 0;idx<js.length;idx++){
        dynamic jsonObject = js[idx];
        if (jsonObject['summary_new'] != null && jsonObject['publishedTimeGap'] != null && jsonObject['imageUrl'] != null && jsonObject['url'] != null && jsonObject['summary_new'] != '' && jsonObject['publishedTimeGap'] != '' && jsonObject['imageUrl'] != '' && jsonObject['url'] != '' ){
          newsArticles.add(NewsArticle(
            title: jsonObject['title'], 
            description: jsonObject['summary_new'], 
            image: jsonObject['imageUrl'], 
            author: 'lijuan', 
            publishdTime: jsonObject['publishedTimeGap'], 
            category: selectedCategories[0], 
            url: jsonObject['url']));
        }
    }
    return newsArticles;
  }
  }



  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final String registerToken = ModalRoute.of(context)?.settings.arguments as String;
    print('newsfeedpage');
    print(registerToken);

    return Scaffold(
      appBar: null,
      body: FutureBuilder<dynamic> (
        future:fetchData(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Text('loading');
          } else if (snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          } else{        
          return Column(
            children: [
              SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Baseline(
                        baselineType: TextBaseline.alphabetic,
                        baseline: 6.0,
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '\nMed',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Arial',
                                  color:Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'Shorts',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Arial',
                                  color: Color(0xFF2CB197),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0), 
                    child:
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                                Icons.account_circle,
                                size: 56,
                                color: Color(0xFF524F4F),
                              ),
                      ), 
                  ),
                ],
              ), 
              SizedBox(height: 10,),
              Divider(
                color: Color(0xFFE6E6E6),
                height: 1,
                thickness: 1.5,
              ),
              SizedBox(height:0.5),
              Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imagePaths.length,
                        itemBuilder: (BuildContext context, int index) {
                          final imagePath = imagePaths[index];
                          final imageName = categoryNames[index];
                          final color = backgroundColors[index];
                          final category = categoryNames[index];
                    
                          return Padding(
                    
                            padding: EdgeInsets.all(1.5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  //Multiple choices
                                  // if (selectedCategories.contains(category)) {
                                  //   selectedCategories.remove(category);
                                  // } else {
                                  //   selectedCategories.add(category);
                                  // }
                                  //Only one choices
                                  selectedCategories = [category];
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 78.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          color: selectedCategories.contains(category) ? color : Colors.transparent,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: 78.0,
                                            height: 60.0,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                imagePath,
                                                width: 38.0,
                                                height: 38,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              '$imageName',
                                              style: TextStyle(fontSize: 12.0, fontFamily: 'Arial',),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (imagePaths.length > 5)
                      Icon(Icons.more_vert),
                  ],
                ),
            ),  
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
                    itemCount: getSelectedNewsArticles().length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: NewsCard(article: getSelectedNewsArticles()[index]),
                      );
                  },
                ),
              )
            ),
          ),
        ],
      );
      }},),
    );
  }
}
