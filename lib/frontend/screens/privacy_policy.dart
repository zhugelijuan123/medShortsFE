import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';



class HTMLPage extends StatelessWidget {
  final String htmlContent;
  HTMLPage({required this.htmlContent});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.99,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child:Html(data: htmlContent),
                ),
              ),
              SizedBox(height:30),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                    onPressed: () {
                      
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
                          double.infinity, 40), // Set the desired height
                    ),
                    child: const Text(
                      'Please click to agree',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ),
              SizedBox(height:50),
            ],
          ),
        ),
      )
    );
  }
}