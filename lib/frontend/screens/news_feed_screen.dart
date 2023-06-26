import 'package:flutter/material.dart';
import 'package:medpulse/frontend/widgets/news_card.dart';

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
      description: 'Birds sing in harmonious melodies, creating a serene soundtrack in the tranquil forest.The sun slowly sets, casting a warm golden glow on the horizon.',
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

  List<NewsArticle> getSelectedNewsArticles() {
    if (selectedCategories.length == 0 || selectedCategories.length == categoryNames.length)
      return newsArticles1;
    else{
      List<NewsArticle> filteredArticles = newsArticles1.where((article) => selectedCategories.contains(article.category)).toList();
      return filteredArticles;
    }
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: null,
      body: 
          Column(
            children: [
              SizedBox(height: 70,),
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
                                size: 70,
                                color: Colors.black,
                              ),
                      ), 
                  ),
                ],
              ), 
              SizedBox(height: 15,),
              Divider(
                color: Color(0xFFE6E6E6),
                height: 1,
                thickness: 1.5,
              ),
              SizedBox(height:0.5),
              Container(
                height: 90.0,
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
          SizedBox(height: 12,),
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
      ),
    );
  }
}
