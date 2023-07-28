import 'package:flutter/material.dart';
import 'package:medpulse/backend/services/sign_in.dart';
import 'package:medpulse/frontend/screens/news_feed_screen.dart';
import '../../backend/services/signup.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class VerifyMfaSignIn extends StatefulWidget {
  @override
  _VerifyMfaScreenState createState() => _VerifyMfaScreenState();
}

class _VerifyMfaScreenState extends State<VerifyMfaSignIn> {
  List<String> otpCodeList = List.filled(6, '');
  final List<TextEditingController> textControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  String otpValidateToken = '';
  String? errorHint = null;
  String verifyLogin = '';
  String userEmail = '';
  String validateString = '';
  String loginString = '';
  String accessToken = '';


  Future<void> loginVerifyMfaAsync(validateString, loginString) async {
    String otpCode = otpCodeList.join();    

    otpValidateToken = await verifyMfaLogin(otpCode, validateString, loginString);
   
    if (otpValidateToken == '') {
      errorHint = 'Wrong code';
    } else {
      await saveMfaCookie(otpValidateToken);
      String loginRedirectToken = await redirectUserToken(otpValidateToken);
      accessToken = await middleWare(loginRedirectToken);

      if (accessToken == ''){
        errorHint = 'error hint equal to null!';
      }
      else{
        final storage = const FlutterSecureStorage();
      // to save token in local storage
        await storage.write(key: 'token', value: accessToken);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  NewsFeedScreen(email:userEmail, selectedLanguage: 'en-US',),
            settings: RouteSettings(arguments: accessToken)
            ),
        );
      }
    }    
  }

  void onChangedHandler(int index, String value) {
    if (value.isNotEmpty) {
      setState(() {
        otpCodeList[index] = value;
      });

      if (index < 5) {
        focusNodes[index + 1].requestFocus();
      } else {
        // Automatically verify OTP when the last field is filled
        // loginVerifyMfaAsync(validateString, loginString);
      }
    }
  }

  @override
  void dispose() {
    textControllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> gotArguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    validateString = gotArguments?['validate']??'';
    loginString = gotArguments?['loginString']??'';
    userEmail = gotArguments?['email']??'';

    // final String verifyLogin =
    //     ModalRoute.of(context)?.settings.arguments as String;
    List<Widget> otpFields = List.generate(
      6,
      (index) => SizedBox(
        width: 50,
        height: 50,
        child: TextField(
          controller: textControllers[index],
          focusNode: focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          onChanged: (value) => onChangedHandler(index, value),
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
    otpFields.add(SizedBox(
      width: 30,
      height: 50,
    ));
    otpFields.insert(0, SizedBox(width: 30, height: 50));

    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 150),
            Text(
              'Enter your security code',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Arial',
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: otpFields,
            ),
            SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () async {
                  await loginVerifyMfaAsync(validateString, loginString);
                  if (errorHint != null)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Wrong code!",
                          style: TextStyle(color: Colors.red, fontSize: 30),
                        ),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  errorHint = null;
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF414BB2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                          0), // Set the border radius to 0 for right angles
                    ),
                  ),
                  minimumSize:
                      const Size(double.infinity, 50), // Set the desired height
                ),
                child: const Text(
                  'Verify',
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
