import 'package:http/http.dart' as http;
import 'dart:convert';

var headers = {
  'true-client-ip': '10.0.0.0',
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'meta-transid': 'testlogin-1234',
  // 'Cookie': 'ak_bmsc=AA6AF004C30628D88AAECEED221CDC6F~000000000000000000000000000000~YAAQSd/aFz7prEmJAQAAJBmiSxQ0ArK93eALUnCRMl8QfHvYZzg840WDhAqxOYrQqcRr4wqzdxP+bJJzbQLw0eJvjAZyel3RiVHV77eyC+QjwdpeVbddJ0G/2nwmjf0Hzx3zGX++xKuF3k3tNuHlxzWHa0CFdHbZt7MLDFnYyRj/68IeI6oGWS0pJuokRVl01aBH7/PJ4u0dTDBVaU9xHZwK2+Qau3XeF3FAHVLZ/PPpO3TJgZDTnvsKwavxuRglVX+iALSEM+bl1qtGhnkOTDE1vdwEiaLAMepp7XBPj5Ijy+22vTq0X4tpkGTicxx2Q9RMJDUoiUHchx26EjXqgS/tjhVWhj5VPOtZ9fqjVGAEko6WAqjZAKFWO7pedj/PZOk51Y+UZuqoSlq7DW0=; bm_sv=F799A9DCAF043FEF18B9A2995DC678C1~YAAQSN/aF+sWKUWJAQAAPRKoSxSL111E8WciWMi0d201c6HeFHXHpUtHkyFaKDd6R1Md2Opx+qke+tAAntptWscOwJouotYxOP2N5dZ+2z9NJOdQvotoTISa1YjzvcaOav5iGhO+YwR5prwEM3AhnQWSI8dvsvrShJExN3Dlz/geoKL7+qQeEpFpJWDYXde4UcgwOL9LSd4gHR5RLA4ZSAjJlJExEA0DLFcg+NekR8mfqXYobeG8SWaEvoq7IqnvPjz7F5TqrYyt9f8MBdXhHBM=~1'
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
    print(loginResponse);
    return loginResponse;
  } else {
    print(response.reasonPhrase);

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
print(userEmail);
print(login_otp_token);
http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  String loginResponse = await response.stream.bytesToString();
  return loginResponse;
}
else {
  print(response.reasonPhrase);
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

  // Map<String, String> requestJson = {};
  // otpCode = "604824";
  // String loginValidatedToken = "eyJlbmMiOiJBMjU2R0NNIiwiYWxnIjoiZGlyIn0..JFF8GthfoF4t8Wkf.LTIduSsQFzjB9zgn4DhoZhsLThF4rNoz6YfwobUDsMmEfWSdBZqvcxxzpgWpBRJT-f8sdGg4cvjjFGU1JfjtUvhEuBFhMllvG2aRtI6L_0zxjrkwWHCBcV4P2029hQUboh9kp1tqAbhA7601HfHA4nypqcNJzWJ0_MgqvfLyP06lKHpVutC24J-9PAF-bhdKv4SO9gNO6V4a3jriCD1HX3vrAUY3Y-jgA1p_vqar6afoUq4OtzWdO46-mRsyeaf_V_5SKqkGEtfaxDSsciuHDLz4guNHlE28p4IsIwpSLOK6PF_LQ_pbKddIvHN3YaruYHAyDFXdrd7ioZ53Nci8qkVt6NAG7Jtyx2f8gIXElE3k5BOABJNdmyZhWgsSXR8vfEDGFjMy0zoesqYpOd8Ze80zJMIKSw2cn8hLPCgR4M72cnXDZkmHQ-3KbET4dzLWF41kB9yExCMxOiA9MUkIsPj99Gkdn2Sn2xuglGhjeesYJPMdgSKIdnoYa-oiQFJFNKrFv86Xblr_xZ7b9WoZ4gwByDhxN3rRX-B3tz9MdUUeRKdmO13R4fCGAv2eGRBC2BIm_HHbocYJ1jBIRHb1JJ5OsDoYBrtzyUi1XEsN9Td-NUFAaosp6grX5AHpOaFjL9ZZ1dq3-MqoH8Ex05juQLA53Cks5ZsrVUn_nv9F8NitdVbPmxDQcwyVh9ada2_Kl2x-tntkkG4ntSfl66u4qjCt34ra3xLCDy517UVmf1eb-nhTaT4sIutgo3kQflwr3EmMTuCo02gokswOVpCVvN0dHPCLHlBNwEMUISKYwmBzy99y-pWImrsGA46B05ttJTXixUJt0pa8lx8VK-phDocUP3Q97HrDxY-X0-mJ4FE4RGNwaLK4Y7hlwXHjvvj8iJMpMXTzqUshsIOLoNxCYmXYhJuB8TDQ9Tv6gCykNJMB0qubq-bgYBOETxSuWQDS7HqYc8p6zNWme3K9fUwF9cxmQRbC5NItGM--9j-G-ZF1LQZ2MqHNVWd50_99BBZFcnnzsiAWP6itt96XPsbBZw7NjyA8WCMIAOt4W06eR-5cVsrcocec-fIGuvruNMhVrOjThi6TgTFINvQok11ebsS64DMGjk3DdhxrltVIbYNfve1Uff5vSgFhzPd3jKfRS5dGInsLFwHly9IMzA5bBQBDEKcFz845lDhKjHePhSXU2JL-MNnwQ4ku9pz5lr9h2MUyJwXv_Jihx75vbqP7NnesDXLiJuQz1IKky-bBW9hXu568kXHrvShlpeadELfJc7xOps0VNzMCTvZcv4gWtGduyrkOF0UVhUp4D1BeHhBZ9SQM-5C9ydaPzCs8wogTeUdom67yF78olaGYxcBWB-yQx62GZQ8VX38uLZbN9V_JVyoB4L4kOZoHgfWK5UQ-KCbVRVmJqmoq9TNOFxo5_MCvmaTW0LJ3hnxFLpra1iPuZltwQUuW7a3iDHmqCY5ovrlltNN-9PLhlLEcsDb161RGpH6YzUCKKPE-U9XJk5LSx6Tparz15lV1grIamKj5kBg_uU8HBjLjtFBO4XlO9vmp_l57fCvjoLHe-RGLq8KJ5CSDEy-jdExjvivcGQ9Uy4-1kCqBsvLOhlmG8pC8V_-cqDlDlrogHYeS3U6tF3DG5WT7asxyi77dXHzJFLS_TAEb39THvKOUHE7GZz1QUYg1yuiHY3Q3Vs4b0_WOCDDetOvaT1uMs9YdlT38Q_XThIS6B6X0xRDolfE50KmZvk-aZarPjND64B4kqGL9xbafmifFHjweXVCtKPSsQRltFLw4euy2Y7Uu3LAsKJQdS2YNfhwE37_18hX5O6HvJZrZvdvH_TCzqZzyqLvxqFH13iDF1p_OhB37lgSw_LE4XR3DFjnFTJQ-aYDWbMmYg5MmeQJgKKnkkjHeOnN-vLN56a8OBZcTt3fZmjLShOQnmLIuqYsfczLhtw9O7rhOWoj2Y1SURVmU6mUZWPJTnYIaSbFJ859fR_9hqILDd2CuktixcnRGhkppslvC3J9cc-PJEtQc-q3AM5bjiQX1cXkHqVMJlxMAtcKAyR4nWmJLodaNuUnBGqgsvzp2NpLQIhq5P4quJnmy7dpYLBVuceaLItYg4drqu2ibSPBAORJd1vjce-WyWEsgILfrQ2qI0awZCkw4CV1euMP3PKec7jdUtmu7UHl7mUbJ4ksAevB0NEUvp2M7ig.ET27uW20eSyU7R5uCPWAOg";
  // String pingRiskId = "cfef7fc1-a83a-4020-bfdf-2e0c153b2d96";
  // String pingUserId = "f06cfb4f-2573-4410-bb8a-02fe606c1691";
  // String pingDeviceId = "1792d8f9-d5a2-4f54-9bc7-9bc3ba5ea2b1";
  // requestJson["pingUserId"] = pingUserId;
  // requestJson["pingDeviceId"] = pingDeviceId;

  requestJson["otp"] = otpCode;
  requestJson["pingRiskId"] = pingRiskId;
  requestJson["token"] = loginValidatedToken;
  print(loginValidatedToken.toString());

  print(requestJson);
  
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
    print('verify mfa of login failed');
    print(response.reasonPhrase);
    print(response.statusCode);
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
    print(response.reasonPhrase);
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
    print(response.reasonPhrase);
    return '';
  }

}