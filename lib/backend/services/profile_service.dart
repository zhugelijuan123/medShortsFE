import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medpulse/frontend/widgets/news_card.dart';


Future<dynamic> userInfo(accessToken) async {
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
    await response.stream.bytesToString();
  }
  else {
    print(response.statusCode);
  }

}


NewsArticle convertToArticle(Map<String, dynamic> jsonData) {
  // Convert each item in the list to GraphQL format
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



Future<List<NewsArticle>> getProfile(acceeToken) async {
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
    for (int idx = newsList.length - 1;idx >= 0;idx--){
      jsonData = newsList[idx];
      articlesList.add(NewsArticle(title:  jsonData["title"].toString(), description:  jsonData["description"].toString(), image:  jsonData["image"].toString(), author: jsonData["author"].toString(), publishdTime:  jsonData["publishdTime"].toString(), category: jsonData['category'].toString(), url: jsonData['url'].toString()));
    }
    return articlesList;
  }
  else {
    return [];
  }

}

