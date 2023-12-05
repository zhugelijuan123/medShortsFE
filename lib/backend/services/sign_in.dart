import 'package:http/http.dart' as http;
import 'dart:convert';

var headers = {
  'true-client-ip': '10.0.0.0',
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'meta-transid': 'testlogin-1234',
};

Future<String> login(userEmail, userPassword) async {
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://web.stg.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v2/consumer/login'));
  request.body = json.encode({
    "email": userEmail,
    "tenantId": "anthem",
    "appId": "caremarket-consumer",
    "password": userPassword
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String loginResponse = await response.stream.bytesToString();
    return loginResponse;
  } else {
    return '';
  }
}


Future<String> sendMfa(userEmail, login_otp_token) async {
  var headers = {
  'true-client-ip': '10.0.0.0',
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'meta-transid': 'login-12345'
};
var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v1/consumer/sendMfa'));
request.body = json.encode({
  "contactInfo": {
    "channel": "email",
    "value": userEmail
  },
  "token": login_otp_token.toString()
});
request.headers.addAll(headers);
http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  String loginResponse = await response.stream.bytesToString();
  return loginResponse;
}
else {
  return '';
}

}


Future<String> verifyMfaLogin(otpCode, jsonString, loginString) async {
  var headers = {
  'true-client-ip': '10.0.0.0',
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'meta-transid': 'login-12345'
  };

  var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v1/consumer/verifyMfa'));
  Map<String, dynamic> jsonData = jsonDecode(jsonString);
  
  List<String> keys = ['pingUserId','pingDeviceId'];

  

  Map<String, dynamic> requestJson = Map.fromEntries(
      keys.where((key) => jsonData.containsKey(key)).map((key) => MapEntry(key, jsonData[key])));
  
  Map<String, dynamic> loginData = jsonDecode(loginString);
  String loginValidatedToken =  loginData['tokenDto']['token'];
  String pingRiskId = loginData['tokenDto']['pingRiskId'];

  requestJson["otp"] = otpCode;
  requestJson["pingRiskId"] = pingRiskId;
  requestJson["token"] = loginValidatedToken;
  
  request.body = json.encode(requestJson);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String mfaVerify = await response.stream.bytesToString();
    Map<String, dynamic> jsonData = jsonDecode(mfaVerify);
    String otpValidatedToken = jsonData['token'];
    return otpValidatedToken;
  }
  else {
    return '';
  }
}


Future<String> saveMfaCookie(OTP_VALIDATED_TOKEN) async {
  var headers = {
  'true-client-ip': '10.0.0.0',
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'meta-transid': 'login-12345'
  };
  var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v1/consumer/saveMfaCookie'));
  request.body = json.encode({
    "saveDeviceOrCookieFlag": true,
    "token":OTP_VALIDATED_TOKEN
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String cookieResponse = await response.stream.bytesToString();
    return cookieResponse;
  }
  else {
    return '';
  }

}


Future<String> redirectUserToken(OTP_VALIDATED_TOKEN) async {
  var headers = {
  'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v2/consumer/redirecttousertoken'));
  request.body = json.encode({
    "token": OTP_VALIDATED_TOKEN
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String redirectResponse = await response.stream.bytesToString();
    Map<String, dynamic> jsonData = jsonDecode(redirectResponse);
    String loginRedirectToken = jsonData['tokenDto']['token'];
    return loginRedirectToken;
  }
  else {
    return '';
  }

}