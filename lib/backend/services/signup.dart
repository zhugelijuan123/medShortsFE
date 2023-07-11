import 'package:http/http.dart' as http;
import 'dart:convert';

var headers = {
  'true-client-ip': '10.0.0.0',
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'meta-transid': 'registration-12345'
  };

Future<String> validateregistration(userEmail) async {
  var request = http.Request('POST', Uri.parse('https://web.sit1.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v2/consumer/validateregistration'));
  request.body = json.encode({
    "email": userEmail,
    "tenantId": "anthem",
    "appId": "caremarket-consumer"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String validateResponse = await response.stream.bytesToString();
    print('validateregistration');
    print(validateResponse);
    
    return validateResponse;
  }
  else {
    print(response.reasonPhrase);
    return '';
  }
}

Future<String> verifyMfa(otpCode, jsonString) async {
  var request = http.Request('POST', Uri.parse('https://web.sit1.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v1/consumer/verifyMfa'));
  Map<String, dynamic> jsonData = jsonDecode(jsonString);

  List<String> keys = ['token','pingRiskId','pingUserId','pingDeviceId'];

  Map<String, dynamic> requestJson = Map.fromEntries(
      keys.where((key) => jsonData.containsKey(key)).map((key) => MapEntry(key, jsonData[key])));

  requestJson["otp"] = otpCode;
  print('requestJson' );
  print( json.encode(requestJson));
  request.body = json.encode(requestJson);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String mfaVerify = await response.stream.bytesToString();
    Map<String, dynamic> jsonData = jsonDecode(mfaVerify);
    String otpValidatedToken = jsonData['token'];
    print('otpvalidatedtoken');
    print(otpValidatedToken);
    return otpValidatedToken;
  }
  else {
    print('statuscode');
    print(response.reasonPhrase);
    return '';
  }
}

Future<dynamic> register(otp_token, password) async {
  var request = http.Request('POST', Uri.parse('https://web.sit1.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v2/consumer/register'));
  print('register');
  print(otp_token);
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
    print('registerToken');
    print(registerToken);
    return registerToken;
  }
  else {
    print(response.reasonPhrase);
    return '';
  }

}


