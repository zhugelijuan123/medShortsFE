import 'package:flutter/material.dart';
import 'package:medpulse/backend/services/signup.dart';
import 'package:medpulse/frontend/screens/verifyMfa_signin.dart';
import '../../backend/services/sign_in.dart';
import 'news_feed_screen.dart';
import 'dart:convert';


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
  String? errorHint = null;
  String verifyLogin = '';

  Future<void> loginAsync(userEmail, userPassword) async {
    String loginString = await login(userEmail, userPassword);
    if (loginString == ''){
      errorHint = 'wrong login info';
    } else{
      Map<String, dynamic> jsonData = jsonDecode(loginString);
      String loginOtpToken = jsonData['tokenDto']['token'];
      String validateString = await sendMfa(userEmail, loginOtpToken);
      if (validateString == '' || loginString == '') {
        errorHint = 'wrong login info';
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerifyMfaSignIn(),
              settings: RouteSettings(arguments:{'validate': validateString, 'loginString':loginString, 'email':userEmail})),
        );
      }
    }
  }

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
              onChanged: (value) {
                setState(() {
                  userEmail =
                      value; // Update the userInput variable with the user's input
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  userPassword =
                      value; // Update the userInput variable with the user's input
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Implement signin logic here
                if (isLoginInfoVerified(userEmail, userPassword)) {
                  
                  await loginAsync(userEmail, userPassword);
                  if (errorHint != null){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Log in information is wrong!",
                            style: TextStyle(color:Colors.red, fontSize: 20),),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,),);
                      errorHint = null;
                    }
                } else {
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
