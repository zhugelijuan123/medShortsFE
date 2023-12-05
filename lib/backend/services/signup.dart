import 'package:http/http.dart' as http;
import 'dart:convert';

var headers = {
  'true-client-ip': '10.0.0.0',
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'meta-transid': 'registration-12345'
  };

Future<String> validateregistration(userEmail) async {
  var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v2/consumer/validateregistration'));
  request.body = json.encode({
    "email": userEmail,
    "tenantId": "anthem",
    "appId": "caremarket-consumer"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String validateResponse = await response.stream.bytesToString();
    return validateResponse;
  }
  else {
    return '';
  }
}

Future<String> verifyMfa(otpCode, jsonString) async {
  var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v1/consumer/verifyMfa'));
  Map<String, dynamic> jsonData = jsonDecode(jsonString);
  List<String> keys = ['token','pingRiskId','pingUserId','pingDeviceId'];

  Map<String, dynamic> requestJson = Map.fromEntries(
      keys.where((key) => jsonData.containsKey(key)).map((key) => MapEntry(key, jsonData[key])));

  requestJson["otp"] = otpCode;
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

Future<dynamic> register(otp_token, password) async {
  var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v2/consumer/register'));
  
  request.body = json.encode({
    "userDetails": {
      "password": password
    },
    "token": otp_token
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String registerResponse = await response.stream.bytesToString();
    Map<String, dynamic> jsonData = jsonDecode(registerResponse);
    String registerToken = jsonData['tokenDto']['token'];
    return registerToken;
  }
  else {
    return '';
  }

}

Future<dynamic> middleWare(auth_session) async {
  var headers = {
      'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpocareMiddlewareServices/v2/oidc/grant/auth_code'));
  request.body = json.encode({
    "auth_session": auth_session
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String middleWareResponse = await response.stream.bytesToString();
    Map<String, dynamic> jsonData = jsonDecode(middleWareResponse);
    String accessToken = jsonData['access_token'];
    return accessToken;
  }
  else {
    return '';
  }
}




