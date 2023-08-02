import 'package:flutter/material.dart';
import 'validate_registration_screen.dart';
import 'signin_screen.dart';
import 'news_feed_screen.dart';
import '../../constants/constants.dart';


class SwipeCombination extends StatefulWidget {
  @override
  _SwipeCombinationState createState() => _SwipeCombinationState();
}

class _SwipeCombinationState extends State<SwipeCombination> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<List<Widget>> combinations = [
    [
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
                  fontFamily: 'Ubuntu',
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'Shorts',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Ubuntu',
                  color: Color(0xFF414BB2),
                ),
              ),
            ],
          ),
        ),
      ),
      const Row(
        children: [
          SizedBox(width: 70), // Add space using SizedBox
          Flexible(
            child: Text(
              'Rapid insights into the medical world',
              style: TextStyle(
                fontSize: 15, // Adjust the font size
                color: Colors.black, // Set the text color
                letterSpacing: 1, // Set the letter spacing
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                // Add more style properties as needed
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 110),
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'You might be here for new trends',
              style: TextStyle(
                fontSize: 20, // Adjust the font size
                color: Colors.black, // Set the text color
                fontFamily: 'ArchivoBlack',
                // fontWeight: FontWeight.bold,
                // Add more style properties as needed
              ),
            ),
          ),
          
        ],
      ),
       Center(
         child: Text(
                'in Healthcare...',
                style: TextStyle(
                  fontSize: 20, // Adjust the font size
                  color: Colors.black, // Set the text color
                  fontFamily: 'ArchivoBlack',
                  // fontWeight: FontWeight.bold,
                  // Add more style properties as needed
                ),
              ),
       ),
      Center(
        child: Text(
                '\nBut that\'s just the start!\n',
                style: TextStyle(
                  fontSize: 18, // Adjust the font size
                  color: Colors.black, // Set the text color
                  letterSpacing: 1, // Set the letter spacing
                  fontFamily: 'Arial',
                  // Add more style properties as needed
                ),
              ),
      ),
      Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF414BB2),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF414BB2),
                        spreadRadius: 2,
                        blurRadius: 2,
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
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0,
                        blurRadius: 0,
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
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    ],
    [
      Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          const Text(
            'Get updates on the latest health news',
            style: TextStyle(
              fontFamily: 'Times New Roman',
              fontStyle: FontStyle.italic,
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    width: 300,
                    height: 150,
                    color: Color(0xFFE6E6E6).withOpacity(.9),
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Image.asset(
                        'assets/images/pillScreenshot.png',
                        width: 300,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    margin: const EdgeInsets.only(top: 120),
                    width: 300,
                    height: 150,
                    color: Color(0xFF75AC3F).withOpacity(.63),
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Image.asset(
                        'assets/images/syringeScreenshot.png',
                        width: 300,
                        height: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0,
                        blurRadius: 0,
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
                    color: Color(0xFF414BB2),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF414BB2),
                        spreadRadius: 2,
                        blurRadius: 2,
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
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      
    ],
    [
      Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
          ),
          const Text(
            'Choose categories of interest',
            style: TextStyle(
              fontFamily: 'Times New Roman',
              fontStyle: FontStyle.italic,
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Image.asset(
                      'assets/images/interestCategories.png',
                      width: 350,
                      height: 350,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0,
                        blurRadius: 0,
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
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0,
                        blurRadius: 0,
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
                    color: Color(0xFF414BB2),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF414BB2),
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    ],
  ];


  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Container(
            height: 560, // Define the desired height
            child: PageView.builder(
              controller: _pageController,
              itemCount: combinations.length,
              itemBuilder: (BuildContext context, int index) {
                return ListView(
                  children: combinations[index],
                );
              },
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ValidateRegistrationScreen()),
                    );
                    // Add your signup button logic here
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
          const SizedBox(height: 20,),
          Row(children: [
            SizedBox(width:28),
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
                  fontSize: 15,  
                  // Set the text color to blue
                ),
              ),
            )
          ],),
          const SizedBox(height: 12,),
          Row(children: [
            SizedBox(width:28),
            InkWell(
              onTap: () {
                // Navigate to another page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsFeedScreen(email:'Not logged in', selectedLanguage:'en-US',)),
                );
              },
              child: const Text(
                'Continue without account',
                style: TextStyle(
                  color: Color(0xFF414BB2), 
                  fontWeight: FontWeight.bold,  
                  fontSize: 15,  
                  // Set the text color to blue
                ),
              ),
            )
          ],),
          const SizedBox(height: 12,),
          Row(children: [
            SizedBox(width:28),
            InkWell(
              onTap: () {
                // Navigate to another page
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  Placeholder()),
                // );
                launchURL('https://www.freeprivacypolicy.com/live/884592be-6e63-4312-8fc6-35c02dc8068b'); // Replace with your website URL

              },
              child: const Text(
                'Privacy',
                style: TextStyle(
                  color: Color(0xFF414BB2), 
                  fontWeight: FontWeight.bold,  
                  fontSize: 15,  
                  // Set the text color to blue
                ),
              ),
            )
          ],),
        ],
      ),
    );
  }
}
