import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = 'http://10.34.26.11:8000';

Future<List<String>> fetchFirmNames() async {
  final response = await http.get(Uri.parse('$baseUrl/firm_names'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<String> firmNames = data.cast<String>();
    return firmNames;
  } else {
    List<String> firmNames = [];
    return firmNames;
  }
}

Future<List<dynamic>> fetchFirmDetails(String firmName) async {
  final response = await http.get(Uri.parse('$baseUrl/firm_details?firm_name=$firmName'));

  if (response.statusCode == 200) {
    List<dynamic> firmDetails = json.decode(response.body);
    return firmDetails;
  } else {
    throw Exception('Failed to load firm details');
  }
}

Future<List<dynamic>> fetchFirmSentimentDetails(String firmName) async {
  final response = await http.get(Uri.parse('$baseUrl/firm_sentiment_details?firm_name=$firmName'));

  if (response.statusCode == 200) {
    List<dynamic> firmSentimentDetails = json.decode(response.body);
    return firmSentimentDetails;
  } else {
    throw Exception('Failed to load firm sentiment details');
  }
}

Future<List<dynamic>> fetchYearCount(String firmName) async {
  final response = await http.get(Uri.parse('$baseUrl/year_count?firm_name=$firmName'));

  if (response.statusCode == 200) {
    List<dynamic> yearCount = json.decode(response.body);
    return yearCount;
  } else {
    throw Exception('Failed to load year count');
  }
}

Future<List<dynamic>> fetchTitleCount(String firmName) async {
  final response = await http.get(Uri.parse('$baseUrl/title_count?firm_name=$firmName'));

  if (response.statusCode == 200) {
    List<dynamic> titleCount = json.decode(response.body);
    return titleCount;
  } else {
    throw Exception('Failed to load title count');
  }
}


