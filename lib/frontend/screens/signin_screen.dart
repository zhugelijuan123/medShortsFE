import 'package:flutter/material.dart';
import 'news_feed_screen.dart';


bool isLoginInfoVerified(String email, String password) {
  // Regular expression pattern for email validation
  return true;
}

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String userEmail = '';
  String userPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value){
                setState(() {
                  userEmail = value; // Update the userInput variable with the user's input
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              onChanged: (value){
                setState(() {
                  userPassword = value; // Update the userInput variable with the user's input
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement signin logic here
                if (isLoginInfoVerified(userEmail, userPassword)){
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  NewsFeedScreen(email:'Not logged in', selectedLanguage: 'en-US',)),
                      );
                  }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Wrong email or password'),
                    ),
                  );
                }                
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
