import 'package:flutter/material.dart';
import 'news_feed_screen.dart';

bool isEmailValid(String email) {
  // Regular expression pattern for email validation
  final emailRegex = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$';

  // Create a RegExp object with the email pattern
  final regex = RegExp(emailRegex);

  // Use the RegExp's hasMatch method to check if the email matches the pattern
  return regex.hasMatch(email);
}

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



class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String userEmail = '';
  String userPassword = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement signup logic here
                print(userEmail + userPassword + confirmPassword);
                if (!isEmailValid(userEmail)){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid email'),
                    ),
                  );
                }
                else if (!isPasswordValid(userPassword)){
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
                  print('correct signup info');
                  //todo: push user sign up info to database
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  NewsFeedScreen()),
                      );
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
