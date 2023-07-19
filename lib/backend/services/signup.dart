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
    return validateResponse;
  }
  else {
    print('validate registration failed');
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
    print('verify mfa failed');
    print(response.reasonPhrase);
    return '';
  }
}

Future<dynamic> register(otp_token, password) async {
  var request = http.Request('POST', Uri.parse('https://web.sit1.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v2/consumer/register'));
  
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
    print('register failed');
    print(response.reasonPhrase);
    return '';
  }

}

Future<dynamic> middleWare(auth_session) async {
  var headers = {
      'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://web.sit1.platform.caremarket.ai/api/xpocareMiddlewareServices/v2/oidc/grant/auth_code'));
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
    print('middle ware pkce failed');
    print(response.reasonPhrase);
    return '';
  }
}


Future<dynamic> userInfo(accessToken) async {
  // accessToken = 'eyJhbGciOiJSUzI1NiIsImtpZCI6InBsYXRmb3JtLWF1dGgifQ.eyJhY2Nlc3NfdG9rZW4iOiJPRGhtT1RjMFlqa3RZV0UwT0MwMFl6aGpMV0psTXpVdE5qVXhNMk13TVdWak1qQTBMVEYyYldsTlYwSkVkMmxsT1dWb1EwZzNURXd5YlRFd09XaFJhejA9IiwidXNlcl9jbGllbnRfaW5mbyI6eyJ4LWFwcC1pZCI6ImNhcmVtYXJrZXQtY29uc3VtZXIiLCJ4LXRlbmFudC1pZCI6ImFudGhlbSJ9LCJhdWRpZW5jZSI6Inhwb3RlY2gtc2VydmljZXMiLCJpc3MiOiJwbGF0Zm9ybS1hdXRoIiwiZXhwaXJlc0luIjoxNjg5MjY4NTgwODAzfQ.Q9LAjMO_fC1IOpt5tHNau0gKNrnsBwIU0yA51EhRrCZEpRlpdHpFlinfbXlGAu2dlmSIth32PjrSVRrff5hnogSf8FsLzlL38uflkDtl32I6CC6KzWPuWpzphUhbOb19I0s1eccJXDYz7KEgtFBiyLKUv8duGVyi28wCwZrTVZ85r5YWpSvLqXDD1l9Xhk0nSCoirsQ1KPxaXuSAVjLDUQ5XY4n0c5gGR_BQKpAWkfGPjUoSUb6-KRhxLdON-lkapFNOIv7LZXenbzGUV9CtmbKVmjESZ0jIIBSFHp98wqQgty5hNwCAlpdtrtDKhYMqJYrTeI0juU8gWX4VT1yUcQ';
  var headers = {
    'true-client-ip': '10.0.0.0',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'meta-transid': 'login-12345',
    'userToken': accessToken.toString()
  };
  var request = http.Request('POST', Uri.parse('https://web.sit1.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v2/user/xpocareuserinfo'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String userInfoResponse = await response.stream.bytesToString();
    return userInfoResponse;
  }
  else {
    print('get user info using token failed');
    print(response.reasonPhrase);
    return '';
  }

}

