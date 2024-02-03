import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = 'http://10.34.26.182:8000';

Future<List<dynamic>> fetchSortedFirmAverages(
    bool workLifeBalance,
    bool cultureValues,
    bool diversityInclusion,
    bool careerOpp,
    bool compBenefits,
    bool seniorMgmt,
    bool recommend,
    bool ceoApprov,
    bool reviewRating,
    ) async {
  final String url = '$baseUrl/sorted_firm_averages';

  Map<String, dynamic> data = {
    'work_life_balance': workLifeBalance,
    'culture_values': cultureValues,
    'diversity_inclusion': diversityInclusion,
    'career_opp': careerOpp,
    'comp_benefits': compBenefits,
    'senior_mgmt': seniorMgmt,
    'recommend': recommend,
    'ceo_approv': ceoApprov,
    'review_rating': reviewRating,
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
      List<dynamic> sortedFirmAverages = json.decode(response.body);
      return sortedFirmAverages;
    } else {
      throw Exception('Failed to load sorted firm averages');
    }
  } catch (error) {
    print('Error: $error');
    List<dynamic> sortedFirmAverages = [];
    return sortedFirmAverages;
  }
}

Future<void> addFavourite(String userId,String firm) async {
  final String url = '$baseUrl/add_favourite';
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'userid': userId,
        'firm': firm,
      }),
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

Future<List<dynamic>> fetchFavouritesDetails(String userId) async {
  final response = await http.get(Uri.parse('$baseUrl/get_favourites?userid=$userId'));

  if (response.statusCode == 200) {
    List<dynamic> favDetails = json.decode(response.body);
    return favDetails;
  } else {
    throw Exception('Failed to load user details');
  }
}

Future<void> addUser(String userId,String userName,String userEmail) async {
  final String url = '$baseUrl/add_user';
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'userid': userId,
        'username': userName,
        'useremail': userEmail,
      }),
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

Future<List<dynamic>> fetchUserDetails(String userId) async {
  final response = await http.get(Uri.parse('$baseUrl/get_user?userid=$userId'));

  if (response.statusCode == 200) {
    List<dynamic> userDetails = json.decode(response.body);
    return userDetails;
  } else {
    throw Exception('Failed to load user details');
  }
}

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


