import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medpulse/frontend/widgets/news_card.dart';


Future<dynamic> userInfo(accessToken) async {
  // accessToken = 'eyJhbGciOiJSUzI1NiIsImtpZCI6InBsYXRmb3JtLWF1dGgifQ.eyJhY2Nlc3NfdG9rZW4iOiJPRGhtT1RjMFlqa3RZV0UwT0MwMFl6aGpMV0psTXpVdE5qVXhNMk13TVdWak1qQTBMVEYyYldsTlYwSkVkMmxsT1dWb1EwZzNURXd5YlRFd09XaFJhejA9IiwidXNlcl9jbGllbnRfaW5mbyI6eyJ4LWFwcC1pZCI6ImNhcmVtYXJrZXQtY29uc3VtZXIiLCJ4LXRlbmFudC1pZCI6ImFudGhlbSJ9LCJhdWRpZW5jZSI6Inhwb3RlY2gtc2VydmljZXMiLCJpc3MiOiJwbGF0Zm9ybS1hdXRoIiwiZXhwaXJlc0luIjoxNjg5MjY4NTgwODAzfQ.Q9LAjMO_fC1IOpt5tHNau0gKNrnsBwIU0yA51EhRrCZEpRlpdHpFlinfbXlGAu2dlmSIth32PjrSVRrff5hnogSf8FsLzlL38uflkDtl32I6CC6KzWPuWpzphUhbOb19I0s1eccJXDYz7KEgtFBiyLKUv8duGVyi28wCwZrTVZ85r5YWpSvLqXDD1l9Xhk0nSCoirsQ1KPxaXuSAVjLDUQ5XY4n0c5gGR_BQKpAWkfGPjUoSUb6-KRhxLdON-lkapFNOIv7LZXenbzGUV9CtmbKVmjESZ0jIIBSFHp98wqQgty5hNwCAlpdtrtDKhYMqJYrTeI0juU8gWX4VT1yUcQ';
  var headers = {
    'true-client-ip': '10.0.0.0',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'meta-transid': 'login-12345',
    'userToken': accessToken.toString()
  };
  var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpocareIdentityServices/xpocare/v2/user/xpocareuserinfo'));
 
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String userInfoResponse = await response.stream.bytesToString();
    Map<String, dynamic> jsonData = jsonDecode(userInfoResponse);
    String emailAddress = jsonData['email'];
    return emailAddress;
  }
  else {
    print('get user info using token failed');
    print(response.reasonPhrase);
    return '';
  }
}

Future<dynamic> addProfile(accessToken) async {
    var headers = {
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Connection': 'keep-alive',
    'DNT': '1',
    'Origin': 'http://localhost:3000',
    'userToken': accessToken.toString()
  };
  var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpoCareProfileService/api/v1/internal/graphql'));
  request.body = '''{"query":"mutation {\\n  addProfileV2 (input : {\\n      \\nadditionalDetails: {\\n    news:[]\\n            },\\n            userProfile: {\\n                firstName: \\"firstname\\",\\n                lastName: \\"lastname\\"\\n            }\\n  }\\n        \\n        ) \\n        {\\n            id,\\n            status,\\n            message        }\\n\\n}","variables":{}}''';

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}



String convertToGraphQLFormat(Map<String, dynamic> data) {
  List<String> fields = [];

  // Iterate through the keys in the map
  data.forEach((key, value) {
    // Convert the value to GraphQL query format based on its type
    String formattedValue;
    if (value is String) {
      formattedValue = '"$value"'; // Wrap strings in double quotes
    } else if (value is List) {
      formattedValue = convertListToGraphQLFormat(value); // Handle lists
    } else {
      formattedValue = value.toString();
    }

    // Add the field in GraphQL format to the list
    fields.add('$key: $formattedValue');
  });

  // Join the fields with commas to create the final GraphQL-formatted string
  return '{ ${fields.join(', ')} }';
}

String convertListToGraphQLFormat(List<dynamic> list) {
  // Convert each item in the list to GraphQL format
  List<String> formattedItems = list.map((item) {
    if (item is String) {
      return '"$item"';
    } else {
      return item.toString();
    }
  }).toList();

  // Join the formatted items with commas to create the final GraphQL-formatted list
  return '[ ${formattedItems.join(', ')} ]';
}



Future<dynamic> updateProfile(accessToken, objectList) async {
  var headers = {
  'Accept-Encoding': 'gzip, deflate, br',
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Connection': 'keep-alive',
  'DNT': '1',
  'userToken': accessToken.toString()
  };

  
  List<dynamic> graphQLFormattedObjects = objectList.map((jsonData) => convertToGraphQLFormat(jsonData.toJson())).toList();
  String graphQLFormattedList = '[${graphQLFormattedObjects.join(', ')}]';
  graphQLFormattedList = graphQLFormattedList.replaceAll('"', '\\"');

  var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpoCareProfileService/api/v1/internal/graphql'));
  request.body = '''{"query":"\\nmutation {\\n  updateProfileV2 (\\n       input : {\\n            additionalDetails: {\\n                news:$graphQLFormattedList  \\n            } \\n            \\n      }) \\n        {\\n            status\\n        }\\n}","variables":{}}''';

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}


NewsArticle convertToArticle(Map<String, dynamic> jsonData) {
  // Convert each item in the list to GraphQL format
  // NewsArticle tmpArticle = NewsArticle(title:  jsonData["title"].toString(), description:  jsonData["description"].toString(), image:  jsonData["image"].toString(), author: jsonData["author"].toString(), publishdTime:  jsonData["publishdTime"].toString(), category: jsonData['category'].toString(), url: jsonData['url'].toString());
  // print(tmpArticle);
  NewsArticle tmpArticle = NewsArticle(
            title: 'title', 
            description: 'summary_new', 
            image: 'imageUrl', 
            author: 'lijuan', 
            publishdTime: 'publishedTimeGap', 
            category: '0', 
            url: 'url');
  // Join the formatted items with commas to create the final GraphQL-formatted list
  return tmpArticle;
}



Future<dynamic> getProfile(acceeToken) async {
  var headers = {
  'Accept-Encoding': 'gzip, deflate, br',
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Connection': 'keep-alive',
  'DNT': '1',
  'Origin': 'http://localhost:3000',
  'userToken': acceeToken.toString()
  };

  var request = http.Request('POST', Uri.parse('https://web.stg.platform.caremarket.ai/api/xpoCareProfileService/api/v1/internal/graphql'));
  request.body = '''{"query":"query getProfileV2 {\\n  getProfileV2 {\\n      additionalDetails\\n  }\\n}","variables":{"filterValue":{"maya.key1":"Key1Value","maya.key2":"Key"}}}''';

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String responseData = await response.stream.bytesToString();
    Map<String, dynamic> jsonData = jsonDecode(responseData);
    dynamic newsList = jsonData['data']['getProfileV2']['additionalDetails']['news'];
    List<NewsArticle> articlesList = [];
    for (int idx = 0;idx<newsList.length;idx++){
      jsonData = newsList[idx];
      articlesList.add(NewsArticle(title:  jsonData["title"].toString(), description:  jsonData["description"].toString(), image:  jsonData["image"].toString(), author: jsonData["author"].toString(), publishdTime:  jsonData["publishdTime"].toString(), category: jsonData['category'].toString(), url: jsonData['url'].toString()));
    }

    return articlesList;
    
  }
  else {
    print(response.reasonPhrase);
    return [];
  }

}

