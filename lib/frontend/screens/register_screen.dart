import 'package:flutter/material.dart';
import 'news_feed_screen.dart';
import '../../backend/services/signup.dart';
import 'verifyMfa_screen.dart';



bool isPasswordValid(String password) {
  // Check if the password length is at least 8 characters
  if (password.length < 8) {
    return false;
  }

  // Check if the password contains at least one letter and one number
  bool hasLetter = false;
  bool hasNumber = false;

  for (var char in password.runes) {
    String character = String.fromCharCode(char);
    if (RegExp(r'[a-zA-Z]').hasMatch(character)) {
      hasLetter = true;
    } else if (RegExp(r'[0-9]').hasMatch(character)) {
      hasNumber = true;
    }
  }

  return hasLetter && hasNumber;
}



class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String userEmail = '';
  String userPassword = '';
  String confirmPassword = '';
  String registerToken= '';
  String? errorHint = null;

  Future<void> registerAsync(otpValidateToken, password) async {
    registerToken = await register(otpValidateToken, password);
    if (registerToken == ''){
      errorHint = 'Register failed!';
    }
    else{
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  NewsFeedScreen(),
          settings: RouteSettings(arguments: registerToken)
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String otpValidateToken = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height:150),
            Text('Please set your password',
              style: TextStyle(fontSize: 30, fontFamily: 'Arial',),),
            SizedBox(height:20),
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
            const SizedBox(height: 26.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
              obscureText: true,
              onChanged: (value){
                setState(() {
                  confirmPassword = value; // Update the userInput variable with the user's input
                });
              },
            ),
            const SizedBox(height: 36.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () async {
                  // Implement signup logic here
                  print(userEmail + userPassword + confirmPassword);
                  if (!isPasswordValid(userPassword)){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid password. Minimum length is 8. At least contain 1 letter and 1 number'),
                      ),
                    );
                  }
                  else if (userPassword != confirmPassword){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password doesn\'t match'),
                      ),
                    );
                  }
                  else{
                    await registerAsync(otpValidateToken, userPassword);
                    if (errorHint != null){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Register failed!",
                            style: TextStyle(color:Colors.red, fontSize: 20),),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,),);
                      errorHint = null;
                    }
                  }
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
                    'Sign Up',
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
      ),
    );
  }
}
