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

  // List<String> keyList = ['title', 'description', 'urlToImage','author','publishedAt','url'];

  // List<dynamic> jsonList1 = jsonData['title'];
  // List<dynamic> jsonList2 = jsonData['description'];
  // List<dynamic> jsonList3 = jsonData['url'];


  // for (int i = 0; i < jsonList1.length; i++){
  //   String title = jsonList1[i]['title'];
  //   String description = jsonList2[i]['description'];
  //   String url = jsonList3[i]['url'];
  //   NewsArticle myArticle = NewsArticle(title: title, description: description, image: 'assets/images/mountain.jpeg', author: 'Author2', publishdTime: "23 mins", category: 'Medication', url: url);
  //   articleList.add(myArticle);
  // }

  return articleList;

}



class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final List<String> imagePaths = [
    'assets/images/tech.png',
    'assets/images/medication.png',
    'assets/images/research.png',
    'assets/images/mental_health_ori.png',
    'assets/images/nutrition.png',
    'assets/images/environment.jpeg',
  ];

  final List<String> categoryNames = [
      'Tech',
      'Medication',
      'Research',
      'Mental Health',
      'Nutrition',
      'Environment',
  ];

  final List<String> imageNames = [
    'Tech',
    'Medication',
    'Research',
    'Mental Health',
    'Nutrition',
    'Environment',
  ];

  final List<Color> backgroundColors = [
    Color.fromARGB(255, 239, 250, 227),
    Color.fromARGB(255, 250, 239, 222),
    Color.fromARGB(255, 249, 231, 231),
    Color.fromARGB(255, 239, 243, 254),
    Color.fromARGB(255, 253, 236, 236),
    Color.fromARGB(255, 240, 250, 230),
  ];


final List<NewsArticle> newsArticles1 = [
    NewsArticle(
      title: 'News Headline 1',
      description: 'The UK\'s watchdogs have agreed to a suite of measures to protect consumers from being ripped off by companies during the cost of living crisis. The measures are unlikely to deliver much financial support to Britons who have seen sharp jumps across a raft of their household bills, at the same time as swallowing soaring mortgage costs due to higher interest rates. The CMA is to publish a planned study into the profit margins of supermarkets and fuel retailers on Monday, and will release a study into grocery pricing in the next few weeks. Ofgem has committed to publishing a review of the business energy market over the summer, and the FCA has vowed to examine how banks and building societies passed through interest rate changes.',
      image: 'assets/images/person.jpeg',
      author: 'Author 1',
      publishdTime: '23 mins ago',
      category: 'Tech',
      url:'https://www.today.com/video/ally-love-shares-tips-for-keeping-good-vibes-all-day-long-184084549930',
    ),
    NewsArticle(
      title: 'News Headline 2',
      description: 'The scent of freshly baked cookies fills the kitchen, tempting even the strongest willpower.The aroma of sizzling bacon drifts from the stove, signaling the start of a delicious breakfast.',
      image: 'assets/images/mountain.jpeg',
      author: 'Author 2',
      publishdTime: '2 hours ago',
      category: 'Medication',
      url:'https://www.statnews.com/2023/06/21/cdc-advisory-panel-recommends-seniors-may-get-rsv-vaccine/',
    ),
    NewsArticle(
      title: 'News Headline 2',
      description: 'The scent of freshly baked cookies fills the kitchen, tempting even the strongest willpower.The aroma of sizzling bacon drifts from the stove, signaling the start of a delicious breakfast.',
      image: 'assets/images/mountain.jpeg',
      author: 'Author 2',
      publishdTime: '2 hours ago',
      category: 'Mental Health',
      url:'https://www.statnews.com/2023/06/21/cdc-advisory-panel-recommends-seniors-may-get-rsv-vaccine/',
    ),
    NewsArticle(
      title: 'News Headline 2',
      description: 'The scent of freshly baked cookies fills the kitchen, tempting even the strongest willpower.The aroma of sizzling bacon drifts from the stove, signaling the start of a delicious breakfast.',
      image: 'assets/images/mountain.jpeg',
      author: 'Author 2',
      publishdTime: '2 hours ago',
      category: 'Nutrition',
      url:'https://www.statnews.com/2023/06/21/cdc-advisory-panel-recommends-seniors-may-get-rsv-vaccine/',     
    ),
    NewsArticle(
      title: 'News Headline 2',
      description: 'The scent of freshly baked cookies fills the kitchen, tempting even the strongest willpower.The aroma of sizzling bacon drifts from the stove, signaling the start of a delicious breakfast.',
      image: 'assets/images/mountain.jpeg',
      author: 'Author 2',
      publishdTime: '2 hours ago',
      category: 'Research',
      url:'https://www.statnews.com/2023/06/21/cdc-advisory-panel-recommends-seniors-may-get-rsv-vaccine/',
    ),
    NewsArticle(
      title: 'News Headline 2',
      description: 'The scent of freshly baked cookies fills the kitchen, tempting even the strongest willpower.The aroma of sizzling bacon drifts from the stove, signaling the start of a delicious breakfast.',
      image: 'assets/images/mountain.jpeg',
      author: 'Author 2',
      publishdTime: '2 hours ago',
      category: 'Research',
      url:'https://www.statnews.com/2023/06/21/cdc-advisory-panel-recommends-seniors-may-get-rsv-vaccine/',
    ),
    NewsArticle(
      title: 'News Headline 2',
      description: 'The scent of freshly baked cookies fills the kitchen, tempting even the strongest willpower.The aroma of sizzling bacon drifts from the stove, signaling the start of a delicious breakfast.',
      image: 'assets/images/mountain.jpeg',
      author: 'Author 2',
      publishdTime: '2 hours ago',
      category: 'Environment',
      url:'https://www.statnews.com/2023/06/21/cdc-advisory-panel-recommends-seniors-may-get-rsv-vaccine/',
    ),
    // Add more news articles for menu item 1 as needed
  ];

  List<String> selectedCategories = [];
  List<NewsArticle> newsArticles2 = [];

  Future<List<NewsArticle>> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:8080/fetchnews/'));
    if (response.statusCode == 200){
      final data = response.body;
      List<dynamic> jsonList = json.decode(data);

      newsArticles2 = jsonList
        .where((jsonObject) =>
          jsonObject['description'] != null && jsonObject['publishedAt'] != null && jsonObject['urlToImage'] != null && jsonObject['url'] != null 
        )
        .map((jsonObject){
        return NewsArticle(
          title: jsonObject['title'], 
          description: jsonObject['description'], 
          image: jsonObject['urlToImage'], 
          author: 'lijuan', 
          publishdTime: jsonObject['publishedTimeGap'], 
          category: 'Medication', 
          url: jsonObject['url']);
      }).toList();
      return newsArticles2;

    } else{
      print('Error: ${response.statusCode}');
      return [];
    }
  }

  List<NewsArticle> getSelectedNewsArticles() {
    if (selectedCategories.length == 0 || selectedCategories.length == categoryNames.length)
      return newsArticles2;
    else{
      List<NewsArticle> filteredArticles = newsArticles2.where((article) => selectedCategories.contains(article.category)).toList();
      return filteredArticles;
    }
  }

  final PageController _pageController = PageController();



  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: null,
      body: FutureBuilder<List<NewsArticle>> (
        future:fetchData(),
        builder:(BuildContext context, AsyncSnapshot<List<NewsArticle>> snapshot){
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
                          final imageName = imageNames[index];
                          final color = backgroundColors[index];
                          final category = categoryNames[index];
                    
                          return Padding(
                    
                            padding: EdgeInsets.all(1.5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedCategories.contains(category)) {
                                    selectedCategories.remove(category);
                                  } else {
                                    selectedCategories.add(category);
                                  }
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
