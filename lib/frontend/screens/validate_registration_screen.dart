import 'package:flutter/material.dart';
import 'news_feed_screen.dart';
import '../../backend/services/signup.dart';
import 'verifyMfa_screen.dart';




bool isEmailValid(String email) {
  // Regular expression pattern for email validation
  final emailRegex = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$';

  // Create a RegExp object with the email pattern
  final regex = RegExp(emailRegex);

  // Use the RegExp's hasMatch method to check if the email matches the pattern
  return regex.hasMatch(email);
}



class ValidateRegistrationScreen extends StatefulWidget {
  @override
  _ValidateRegistrationScreenState createState() => _ValidateRegistrationScreenState();
}

class _ValidateRegistrationScreenState extends State<ValidateRegistrationScreen> {
  String userEmail = '';
  String userPassword = '';
  String confirmPassword = '';
  String otpCode = '';
  String? errorHint = null;
  String validateString = '';

  Future<void> validateRegistrationAsync(userEmail) async {
    validateString = await validateregistration(userEmail);
    if(validateString == ''){
      errorHint = 'Email exists!';
    }
    else{
      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  VerifyMfaScreen(),
                          settings: RouteSettings(arguments: {'validate':validateString,'email':userEmail})),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height:90),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text('Create your account', 
                  style:TextStyle(fontSize: 30,fontFamily: 'Ubuntu',fontWeight: FontWeight.bold,) ,),
                ),
              ],
            ),
            const SizedBox(height:16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text('Let\'s get started with your immersive journey', 
                  style:TextStyle(fontSize: 16,fontFamily: 'Arial',color: Colors.grey,) ,),
                ),
              ],
            ),
            const SizedBox(height:40),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(fontSize: 20),
              ),
              onChanged: (value){
                setState(() {
                  userEmail = value; // Update the userInput variable with the user's input
                });
              },
            ),
            const SizedBox(height: 40.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () async {
                  // Implement signup logic here
                  if (!isEmailValid(userEmail)){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid email'),
                      ),
                    );
                  }
                  else{
                    //todo: push user sign up info to database
                    await validateRegistrationAsync(userEmail);
                    if (errorHint != null){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "User exists!",
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
