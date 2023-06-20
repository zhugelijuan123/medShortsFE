import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'signin_screen.dart';
import 'news_feed_screen.dart';
import 'introduction_screen.dart';

class FirstIntroSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: null,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '\nMed',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            color:Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Shorts',
                          style: TextStyle(
                            fontSize: 42,
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
                const Row(
                  children: [
                    SizedBox(width: 80), // Add space using SizedBox
                    Text(
                      'Rapid insights into the medical world',
                      style: TextStyle(
                        fontSize: 20,  // Adjust the font size
                        color: Colors.black,  // Set the text color
                        letterSpacing: 1,  // Set the letter spacing
                        fontFamily: 'Caveat',    
                        fontWeight: FontWeight.bold,                                          
                        // Add more style properties as needed
                      ),
                    ),
                  ],
                ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width:10),
                  Flexible(
                    child: Text(
                      '\n\n\n  You might be here for new trends in Healthcare...\n\n  But that\'s just a start!\n',
                      style: TextStyle(
                        fontSize: 27,  // Adjust the font size
                        color: Colors.black,  // Set the text color
                        letterSpacing: 1,  // Set the letter spacing
                        fontFamily: 'Times New Roman',  
                        fontWeight: FontWeight.bold,                      
                        // Add more style properties as needed
                      ),
                    ),
                  )
                ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 2,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          blurRadius: 0,
                        ),
                      ],
                    ),
                  ),
              ],),
              const SizedBox(height: 60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child:ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                      // Add your signup button logic here
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF414BB2),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0), // Set the border radius to 0 for right angles
                        ),
                      ),
                      minimumSize: const Size(double.infinity, 50), // Set the desired height
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color:Colors.white,                        
                        fontWeight: FontWeight.bold,    
                        fontSize: 18,
                      ),
                      ),
                  ), ),
                ],),
                const SizedBox(height: 30,),
                Row(children: [
                  InkWell(
                    onTap: () {
                      // Navigate to another page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninScreen()),
                      );
                    },
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Color(0xFF414BB2), 
                        fontWeight: FontWeight.bold,  
                        fontSize: 18,  
                        // Set the text color to blue
                      ),
                    ),
                  )
                ],),
                const SizedBox(height: 18,),
                Row(children: [
                  InkWell(
                    onTap: () {
                      // Navigate to another page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SwipeCombination()),
                      );
                    },
                    child: const Text(
                      'Privacy',
                      style: TextStyle(
                        color: Color(0xFF414BB2), 
                        fontWeight: FontWeight.bold,  
                        fontSize: 18,  
                        // Set the text color to blue
                      ),
                    ),
                  )
                ],),
            ],
          ),
      ),
    ),
  );
    
  }
}
