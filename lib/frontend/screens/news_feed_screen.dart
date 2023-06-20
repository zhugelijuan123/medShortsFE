import 'package:flutter/material.dart';

class NewsArticle {
  final String title;
  final String description;
  final String image;
  final String author;
  final DateTime dateTime;

  NewsArticle({
    required this.title,
    required this.description,
    required this.image,
    required this.author,
    required this.dateTime,
  });
}

class NewsCard extends StatelessWidget {
  final NewsArticle article;

  const NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.network(
              article.image,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${article.author} • ${article.dateTime}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class NewsFeedScreen extends StatelessWidget {
//   final List<NewsArticle> newsArticles = [
//     NewsArticle(
//       title: 'News Headline 1',
//       description: 'News description or summary goes here...',
//       image: 'https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8=',
//       author: 'Author 1',
//       dateTime: DateTime.now(),
//     ),
//     NewsArticle(
//       title: 'News Headline 2',
//       description: 'News description or summary goes here...',
//       image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80',
//       author: 'Author 2',
//       dateTime: DateTime.now(),
//     ),
//     // Add more news articles as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Medpulse',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('News for you'),
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                 ),
//                 child: Text(
//                   'Menu',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//               ListTile(
//                 title: Text('All News'),
//                 onTap: () {
//                   // Handle menu item 1 tap
//                 },
//               ),
//               ListTile(
//                 title: Text('Care'),
//                 onTap: () {
//                   // Handle menu item 2 tap
//                 },
//               ),
//               ListTile(
//                 title: Text('Medicine'),
//                 onTap: () {
//                   // Handle menu item 2 tap
//                 },
//               ),            ],
//           ),
//         ),
//         body: SafeArea(
//           child: ListView.builder(
//             itemCount: newsArticles.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: NewsCard(article: newsArticles[index]),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  int selectedIndex = 0;

  final List<NewsArticle> newsArticles1 = [
    NewsArticle(
      title: 'News Headline 1',
      description: 'News description or summary goes here...',
      image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80',
      author: 'Author 1',
      dateTime: DateTime.now(),
    ),
    NewsArticle(
      title: 'News Headline 2',
      description: 'News description or summary goes here...',
      image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80',
      author: 'Author 2',
      dateTime: DateTime.now(),
    ),
    // Add more news articles for menu item 1 as needed
  ];

  final List<NewsArticle> newsArticles2 = [
    NewsArticle(
      title: 'News Headline 3',
      description: 'News description or summary goes here...',
      image: 'https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8=',
      author: 'Author 3',
      dateTime: DateTime.now(),
    ),
    NewsArticle(
      title: 'News Headline 4',
      description: 'News description or summary goes here...',
      image: 'https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8=',
      author: 'Author 4',
      dateTime: DateTime.now(),
    ),
    NewsArticle(
      title: 'News Headline 5',
      description: 'News description or summary goes here...',
      image: 'https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8=',
      author: 'Author 5',
      dateTime: DateTime.now(),
    ),  ];

  List<NewsArticle> getSelectedNewsArticles() {
    if (selectedIndex == 0) {
      return newsArticles1;
    } else if (selectedIndex == 1) {
      return newsArticles2;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inshorts',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Inshorts'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Menu Item 1'),
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
              
                  });
                  print(selectedIndex);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Menu Item 2'),
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                  print(selectedIndex);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: getSelectedNewsArticles().length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: NewsCard(article: getSelectedNewsArticles()[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}