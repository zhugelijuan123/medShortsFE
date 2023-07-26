import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'frontend/screens/validate_registration_screen.dart';
import 'frontend/screens/news_feed_screen.dart';
import 'frontend/screens/introduction_screen.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'backend/services/signup.dart';
import 'backend/services/profile_service.dart';
import 'frontend/screens/podcast.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  String email = 'Not logged in';

  @override
  void initState(){
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final storage = const FlutterSecureStorage();
    var accessToken = await storage.read(key:'token');
    
    if (accessToken != null && accessToken.isNotEmpty){
      String userInfoResponse = await userInfo(accessToken);
      if (userInfoResponse == ''){
        setState(() {
        isLoggedIn = false;
      });
      } else{
        setState(() {
        isLoggedIn = true;
        email = userInfoResponse;
        print(email);
      });
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'MedPulse',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: 
        isLoggedIn?NewsFeedScreen(email:email, selectedLanguage: 'en-US',):SwipeCombination(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = "Lijuan";
}


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;     // ← Add this property.

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Placeholder();
        break;
      case 1:
        page = Placeholder();
        break;
      case 2:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: null,
          body: SwipeCombination(),
        );
      }
    );
  }
}


