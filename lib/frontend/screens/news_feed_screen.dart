import 'package:flutter/material.dart';
import 'package:medpulse/frontend/widgets/news_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'introduction_screen.dart';
import 'saved_news.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../constants/constants.dart';
import 'audio_language.dart';
import 'profile.dart';
import '../../backend/services/profile_service.dart';

class NewsFeedScreen extends StatefulWidget {
  final String email;
  String selectedLanguage;

  NewsFeedScreen({required this.email, required this.selectedLanguage});

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  bool isLoggedIn = false;
  var token;


  @override
  void initState(){
    super.initState();
    // checkLoginStatus();
    
    fetchData();
  }

  List<String> selectedCategories = ['Medication'];
  late dynamic jsonResponse = {};
  final PageController _pageController = PageController();
  List<NewsArticle> pinnedNewsList = [];
  List<bool> newsPinnedFlagList = [];

  String summaryFix(String summary_text){
    // print(summary_text);
  //   List<String> word_list = summary_text.split(' ');
  //   String selectedSummary = '';
  //   int totalChars = 0;
  //   int maxChars = 210;

  //   for (int idx = 0; idx < word_list.length; idx++){
  //     String word = word_list[idx];
  //     if (totalChars + word.length <= maxChars){
  //         selectedSummary += word;
  //         if (idx != word_list.length - 1){
  //           selectedSummary += ' ';
  //         }
  //         totalChars += word.length + 1;
  //     }
  //     else{
  //       break;
  //     }
  //   }
  //  if (selectedSummary == summary_text){
  //   return selectedSummary;
  //  }
  //   return selectedSummary + '...';
  // print(summary_text.length);
  return summary_text;
  }

  Future<void> fetchPinnedNews() async{
    if(widget.email != 'Not logged in'){
      pinnedNewsList = await getProfile(token);
    }
  }

  Future<dynamic> fetchData() async {
    final storage = const FlutterSecureStorage();
    token = await storage.read(key:'token');

    if (token == null && widget.email != 'Not logged in'){
      print('news feed page: token is null but user logged in');
    }

    if (token == null){
      token = '';
    }

    // String url = 'http://localhost:8080/fetchnews/'; //local server
    String url = 'https://medshorts-mc6fph6kbq-uc.a.run.app/fetchnews/'; //remote server

    Map<String, String> headers = {
      'Authorization':'Bearer no account',
    };

    if(widget.email != 'Not logged in'){
      headers = {
      'Authorization':'Bearer $token',
      };
      pinnedNewsList = await getProfile(token);
    }

    print('fetch news now');
    print(headers);
    final response = await http.get(Uri.parse(url), headers: headers);
    print(response.statusCode);

    if (response.statusCode == 200){
      final data = response.body;
      // print('responsebody');
      // print(data);
      Map<String, dynamic> jsonData = json.decode(data);
      // print('jsondata');
      // print(jsonData);
      setState(() {
        jsonResponse = jsonData;
      });
      // print('jsonresponse');
      // print(jsonResponse);
      return jsonResponse;
    } else{
      print('Error: ${response.statusCode}');
      setState(() {
        jsonResponse = 'Auth error';
      });
      return '';
    }
  }

  List<NewsArticle> getSelectedNewsArticles() {
    List<NewsArticle> newsArticles = [];
    
    if (jsonResponse.containsKey(selectedCategories[0])){
      dynamic js = jsonResponse[selectedCategories[0]];
      for (int idx = 0;idx<js.length;idx++){
        dynamic jsonObject = js[idx];
        if (jsonObject['summary_new'] != null && jsonObject['pubDate'] != null && jsonObject['imageUrl'] != null && jsonObject['url'] != null && jsonObject['summary_new'] != '' && jsonObject['pubDate'] != '' && jsonObject['imageUrl'] != '' && jsonObject['url'] != '' ){
          NewsArticle articleItem = NewsArticle(
            title: jsonObject['title'].replaceAll('"',''), 
            description: summaryFix(jsonObject['summary_new'].replaceAll('"','')), 
            image: jsonObject['imageUrl'], 
            author: 'lijuan', 
            publishdTime: jsonObject['pubDate'], 
            category: selectedCategories[0], 
            url: jsonObject['url']);
          newsArticles.add(articleItem);
          if (pinnedNewsList.any((element) => element.title == articleItem.title)){
            newsPinnedFlagList.add(true);
          }
          else{
            newsPinnedFlagList.add(false);
          }
        }
      }
    }
      return newsArticles;
  }

  List<bool> getPinnedFlag() {
    List<bool> tmpNewsPinnedFlagList = [];
    
    if (jsonResponse.containsKey(selectedCategories[0])){
      dynamic js = jsonResponse[selectedCategories[0]];
      for (int idx = 0;idx<js.length;idx++){
        dynamic jsonObject = js[idx];
        if (jsonObject['summary_new'] != null && jsonObject['pubDate'] != null && jsonObject['imageUrl'] != null && jsonObject['url'] != null && jsonObject['summary_new'] != '' && jsonObject['pubDate'] != '' && jsonObject['imageUrl'] != '' && jsonObject['url'] != '' ){
          NewsArticle articleItem = NewsArticle(
            title: jsonObject['title'].replaceAll('"',''), 
            description: summaryFix(jsonObject['summary_new'].replaceAll('"','')), 
            image: jsonObject['imageUrl'], 
            author: 'lijuan', 
            publishdTime: jsonObject['pubDate'], 
            category: selectedCategories[0], 
            url: jsonObject['url']);
          if (pinnedNewsList.any((element) => element.title == articleItem.title)){
            tmpNewsPinnedFlagList.add(true);
          }
          else{
            tmpNewsPinnedFlagList.add(false);
          }
        }
      }
    }
    // print(tmpNewsPinnedFlagList);
    return tmpNewsPinnedFlagList;
  }


  Widget buildDrawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: 
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  SwipeCombination(),
                    ),
                  );
              },
              child: Text('\n\nClick to log in', 
                style: TextStyle(color: Colors.white, fontSize: 20,decoration:TextDecoration.underline, decorationColor: Colors.white),),
            ),
            decoration: BoxDecoration(color: Color(0xFF414BB2)),
          ),
          // ListTile(
          //   title: Text('Audio Language'),
            
          //   onTap: () {
          //     navigateToAudioScreen();
          //   },
          // ),
        ],
      )
    );
  }

  void navigateToAudioScreen() async {
    final updatedLanguage  = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  AudioLanguageScreen(selectedLanguage: widget.selectedLanguage),
              ),
            );
    
    if (updatedLanguage != null){
      setState(() {
        widget.selectedLanguage = updatedLanguage;
      });
    }

  }

  Widget buildLoggedinDrawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
          child: Text('\nWelcome! \n ${widget.email}', style: TextStyle(color: Colors.white, fontSize: 16),),
          decoration: BoxDecoration(color: Color(0xFF414BB2)),
          ),
          ListTile(
            title: Text('Account'),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  ProfileScreen(email:widget.email),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Saved News'),
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => SavedNewsPage(selectedLanguage: widget.selectedLanguage,acceeToken: token,),),);
            },
            
          ),
          // ListTile(
          //   title: Text('Audio Language'),
            
          //   onTap: () {
          //     navigateToAudioScreen();
          //   },
          // ),
          ListTile(
            title: Text('Log out'),
            onTap: () async {
              final storage = const FlutterSecureStorage();
              await storage.delete(key: 'token');
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  SwipeCombination(),
                ),
              );
            },
          ),
        ],
      )
    );
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if( jsonResponse == {}){
      fetchData();
    }
  }

  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
   
    if (jsonResponse == 'Auth error'){
      return Scaffold(
      appBar: null,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 16,),
              Flexible(
                child: Text('Authorization or fetch news failed, please go back to sign up/log in!',
                style: TextStyle(fontSize: 30,),),
              ),
            ],
          ),
          SizedBox(height:30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                              onPressed: () {
                                // Implement signup logic here
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  SwipeCombination(),
                                    ),
                                );
                                
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
        ],
      ));
    }
    else{
        return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(title: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom:15.0,),
            child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '\nMed',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Arial',
                                          color:Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Shorts',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Arial',
                                          color: Color(0xFF414BB2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
          ),
        ),
        centerTitle: true,
        ), ),
      drawer: widget.email == 'Not logged in'?buildDrawer():buildLoggedinDrawer(),
      body: Column(
                children: [
                  // SizedBox(height: 50,),
                  // SizedBox(height: 10,),
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
                                  onTap: () async {

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
                                    await fetchPinnedNews();
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
                            child: NewsCard(article: getSelectedNewsArticles()[index], selectedLanguage: widget.selectedLanguage, accessToken:token, email: widget.email,pinIconFlag:true, isPinnedFlag: getPinnedFlag()[index],),
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



  // @override
  // Widget build(BuildContext context) {
  //   final screenSize = MediaQuery.of(context).size;
  //   return Scaffold(
  //     appBar: null,
  //     drawer: widget.email == 'Not logged in'?buildDrawer():buildLoggedinDrawer(),
  //     body: FutureBuilder<dynamic> (
  //       future:jsonResponse,
  //       builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){
  //         if (snapshot.connectionState == ConnectionState.waiting){
  //           return Center(child:CircularProgressIndicator());
  //         } else if (snapshot.hasError){
  //           return Text('Error: ${snapshot.error}');
  //         } else if (snapshot.hasData){   
  //             jsonResponse = snapshot.data;    
  //             return Column(
  //               children: [
  //                 SizedBox(height: 50,),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: Align(
  //                         alignment: Alignment.centerLeft,
  //                         child: Baseline(
  //                           baselineType: TextBaseline.alphabetic,
  //                           baseline: 6.0,
  //                           child: RichText(
  //                             text: const TextSpan(
  //                               children: [
  //                                 TextSpan(
  //                                   text: '\nMed',
  //                                   style: TextStyle(
  //                                     fontSize: 32,
  //                                     fontWeight: FontWeight.bold,
  //                                     fontFamily: 'Arial',
  //                                     color:Colors.black,
  //                                   ),
  //                                 ),
  //                                 TextSpan(
  //                                   text: 'Shorts',
  //                                   style: TextStyle(
  //                                     fontSize: 32,
  //                                     fontWeight: FontWeight.bold,
  //                                     fontStyle: FontStyle.italic,
  //                                     fontFamily: 'Arial',
  //                                     color: Color(0xFF2CB197),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(right: 10.0), 
  //                       child:
  //                         Align(
  //                           alignment: Alignment.centerRight,
  //                           child: Icon(
  //                                   Icons.account_circle,
  //                                   size: 56,
  //                                   color: Color(0xFF524F4F),
  //                                 ),
  //                         ), 
  //                     ),
  //                   ],
  //                 ), 
  //                 SizedBox(height: 10,),
  //                 Divider(
  //                   color: Color(0xFFE6E6E6),
  //                   height: 1,
  //                   thickness: 1.5,
  //                 ),
  //                 SizedBox(height:0.5),
  //                 Container(
  //                   height: 80,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Expanded(
  //                         child: ListView.builder(
  //                           scrollDirection: Axis.horizontal,
  //                           itemCount: imagePaths.length,
  //                           itemBuilder: (BuildContext context, int index) {
  //                             final imagePath = imagePaths[index];
  //                             final imageName = categoryNames[index];
  //                             final color = backgroundColors[index];
  //                             final category = categoryNames[index];
                        
  //                             return Padding(
                        
  //                               padding: EdgeInsets.all(1.5),
  //                               child: GestureDetector(
  //                                 onTap: () async {
  //                                   setState(() {
  //                                     //Multiple choices
  //                                     // if (selectedCategories.contains(category)) {
  //                                     //   selectedCategories.remove(category);
  //                                     // } else {
  //                                     //   selectedCategories.add(category);
  //                                     // }
  //                                     //Only one choices
  //                                     selectedCategories = [category];
  //                                   });
  //                                   await fetchPinnedNews();
  //                                 },
  //                                 child: Column(
  //                                   children: [
  //                                     Stack(
  //                                       children: [
  //                                         Container(
  //                                           width: 78.0,
  //                                           height: 60.0,
  //                                           decoration: BoxDecoration(
  //                                             color: selectedCategories.contains(category) ? color : Colors.transparent,
  //                                             borderRadius: BorderRadius.circular(10.0),
  //                                           ),
  //                                         ),
  //                                         Column(
  //                                           children: [
  //                                             Container(
  //                                               width: 78.0,
  //                                               height: 60.0,
  //                                               child: Align(
  //                                                 alignment: Alignment.center,
  //                                                 child: Image.asset(
  //                                                   imagePath,
  //                                                   width: 38.0,
  //                                                   height: 38,
  //                                                   fit: BoxFit.cover,
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                             Center(
  //                                               child: Text(
  //                                                 '$imageName',
  //                                                 style: TextStyle(fontSize: 12.0, fontFamily: 'Arial',),
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ],),
  //                                   ],
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                         ),
  //                       ),
  //                       if (imagePaths.length > 5)
  //                         Icon(Icons.more_vert),
  //                     ],
  //                   ),
  //               ),  
  //             Divider(
  //               color: Color(0xFFE6E6E6),
  //               height: 1,
  //               thickness: 1.5,
  //             ),    
  //             SizedBox(height: 9,),
  //             Expanded(
  //               child: Container(
  //                 width:screenSize.width,
  //                 child: 
  //                 MediaQuery.removePadding(
  //                   context: context,
  //                   removeTop: true,
  //                   child: 
  //                     ListView.builder(
  //                       scrollDirection: Axis.vertical,
  //                       itemCount: getSelectedNewsArticles().length,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         return Padding(
  //                           padding: const EdgeInsets.all(2.0),
  //                           child: NewsCard(article: getSelectedNewsArticles()[index], selectedLanguage: widget.selectedLanguage, accessToken:token, email: widget.email,pinIconFlag:true, isPinnedFlag: getPinnedFlag()[index],),
  //                         );
  //                     },
  //                   ),
  //                 )
  //               ),
  //             ),
  //           ],
  //         );
  //     } else{
  //       return Center(child: Text('No data available'),);
  //     }
  //     },),
  //   );
  // }
}
