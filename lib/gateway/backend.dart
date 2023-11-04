import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = 'http://192.168.1.16:8000';

Future<void> sendFirmReviewData(
    String firmName,
    String jobTitle,
    double workLifeBalance,
    double cultureValues,
    double diversityInclusion,
    double careerOpp,
    double compBenefits,
    double seniorMgmt,
    double recommend,
    double ceoApprov,
    double outlook,
    String headline,
    String pros,
    String cons,
    ) async {
  final String url = '$baseUrl/store_firm_review';

  Map<String, dynamic> data = {
    'firm_name': firmName,
    'job_title': jobTitle,
    'work_life_balance': workLifeBalance,
    'culture_values': cultureValues,
    'diversity_inclusion': diversityInclusion,
    'career_opp': careerOpp,
    'comp_benefits': compBenefits,
    'senior_mgmt': seniorMgmt,
    'recommend': recommend,
    'ceo_approv': ceoApprov,
    'outlook': outlook,
    'headline': headline,
    'pros': pros,
    'cons': cons,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Data sent successfully!');
    } else {
      print('Failed to send data. Error: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}

Future<List<String>> fetchFirmNames() async {
  final response = await http.get(Uri.parse('$baseUrl/firm_names'));
  log("test");
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


