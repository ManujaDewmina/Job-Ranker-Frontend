import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_ranker/reusable_widgets/reusable_widget.dart';
import '../Utils/color_utils.dart';
import '../gateway/backend.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}

class DetailedFirmScreen extends StatefulWidget {
  final String firmName;
  const DetailedFirmScreen(this.firmName, {Key? key}) : super(key: key);

  @override
  State<DetailedFirmScreen> createState() => _DetailedFirmScreenState(firmName);
}

class _DetailedFirmScreenState extends State<DetailedFirmScreen> {
  final String firmName;
  List<double> ratings = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];
  List<Map<String, int>> yearCountData = [
    {'year': 0, 'year_count': 0}
  ];
  List<Map<String, dynamic>> titleCountData = [
    {'job_title': "1", 'title_count': 0}
  ];

  _DetailedFirmScreenState(this.firmName);

  Future<List<double>> _loadFirmDetails() async {
    try {
      List<dynamic> data = await fetchFirmDetails(firmName);
      List<dynamic> dataSentiment = await fetchFirmSentimentDetails(firmName);
      List<dynamic> yearCount = await fetchYearCount(firmName);
      List<dynamic> titleCount = await fetchTitleCount(firmName);

      Map<String, dynamic> firmData = data.isNotEmpty ? data[0] : {};
      Map<String, dynamic> firmSentimentDetails =
          dataSentiment.isNotEmpty ? dataSentiment[0] : {};
      yearCountData = yearCount.map((dynamic item) {
        Map<String, int> mappedItem = {
          'year': item['year'] ?? 0,
          'year_count': item['year_count'] ?? 0,
        };
        return mappedItem;
      }).toList();
      titleCountData = titleCount
          .map((dynamic item) {
            Map<String, dynamic> mappedItem = {
              'job_title': item['job_title'] ?? "",
              'title_count': item['title_count'] ?? 0,
            };
            return mappedItem;
          })
          .take(10)
          .toList();
      double workLifeBalance = firmData['work_life_balance'] ?? 0.0;
      double cultureValues = firmData['culture_values'] ?? 0.0;
      double diversityInclusion = firmData['diversity_inclusion'] ?? 0.0;
      double careerOpportunities = firmData['career_opp'] ?? 0.0;
      double companyBenefits = firmData['comp_benefits'] ?? 0.0;
      double seniorManagement = firmData['senior_mgmt'] ?? 0.0;
      double recommendToFriend = firmData['recommend'] ?? 0.0;
      double ceoApproval = firmData['ceo_approv'] ?? 0.0;

      double predicted_score = firmSentimentDetails['predicted_score'] ?? 0.0;
      double pros_predicted_score =
          firmSentimentDetails['pros_predicted_score'] ?? 0.0;
      double cons_predicted_score =
          firmSentimentDetails['cons_predicted_score'] ?? 0.0;
      return [
        workLifeBalance,
        cultureValues,
        diversityInclusion,
        careerOpportunities,
        companyBenefits,
        seniorManagement,
        recommendToFriend,
        ceoApproval,
        predicted_score,
        pros_predicted_score,
        cons_predicted_score
      ];
    } catch (error) {
      print('Error fetching firm details: $error');
      return List.filled(8, 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor("1a3f49"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("1a3f49"),
          hexStringToColor("244e54"),
          hexStringToColor("4EB3A4"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SingleChildScrollView(
            child: FutureBuilder<List<double>>(
              future: _loadFirmDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  ratings = snapshot.data!;
                  return Column(
                    children: <Widget>[
                      Text(
                        firmName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          labelRotation: -90,
                        ),
                        title: ChartTitle(
                            text: 'Job Title vs Number of Reviews',
                            textStyle: const TextStyle(color: Colors.white)),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          ColumnSeries<Map<String, dynamic>, String>(
                              dataSource: titleCountData,
                              xValueMapper: (Map<String, dynamic> data, _) =>
                                  data['job_title'].toString(),
                              yValueMapper: (Map<String, dynamic> data, _) =>
                                  data['title_count'],
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true))
                        ],
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(height: 12),
                      //year cout data in bar chart year vs count
                      SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart title
                        title: ChartTitle(
                            text: 'Year vs Number of Reviews',
                            textStyle: TextStyle(color: Colors.white)),
                        // Enable legend
                        legend: Legend(isVisible: false),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          ColumnSeries<Map<String, int>, String>(
                              dataSource: yearCountData,
                              xValueMapper: (Map<String, int> data, _) =>
                                  data['year'].toString(),
                              yValueMapper: (Map<String, int> data, _) =>
                                  data['year_count'],
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true))
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      'Positive',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.circleMinus,
                                      color: hexStringToColor("1a3f49"),
                                    ),
                                    const SizedBox(width: 8.0),
                                    const Text(
                                      'Negative',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _circleBar("Score for reviews", ratings[8]),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: _circleBar("Score for pros", ratings[9]),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child:
                                    _circleBar("Score for cons", ratings[10]),
                              ),
                            ],
                          ),
                          _buildCategory("Work-Life Balance", ratings[0]),
                          const SizedBox(height: 8),
                          _buildCategory("Culture Values", ratings[1]),
                          const SizedBox(height: 8),
                          _buildCategory("Diversity & Inclusion", ratings[2]),
                          const SizedBox(height: 8),
                          _buildCategory("Career Opportunities", ratings[3]),
                          const SizedBox(height: 8),
                          _buildCategory("Company Benefits", ratings[4]),
                          const SizedBox(height: 8),
                          _buildCategory("Senior Management", ratings[5]),
                          const SizedBox(height: 8),
                          _buildCategory("Recommend to a Friend", ratings[6]),
                          const SizedBox(height: 8),
                          _buildCategory("CEO Approval", ratings[7]),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
      drawer: appDrawer(context),
    );
  }

  Widget _circleBar(String topic, double rating) {
    return SfCircularChart(
      //circular chart
      title: ChartTitle(
        text: topic,
        textStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      margin: const EdgeInsets.only(top: 1.0),
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          dataSource: <ChartData>[
            ChartData('Good', rating * 100),
            ChartData('Bad', 100 - rating * 100),
          ],
          xValueMapper: (ChartData data, _) => data.x,
          pointColorMapper: (ChartData data, _) =>
              data.x == 'Good' ? Colors.green : hexStringToColor("1a3f49"),
          yValueMapper: (ChartData data, _) => data.y,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
          ),
        ),
      ],
    );
  }

  Widget _buildCategory(String categoryName, double rating) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: hexStringToColor("244e54"),
        borderRadius: BorderRadius.circular(
            10), // You can adjust the radius as per your preference
      ),
      child: Column(
        children: <Widget>[
          Text(categoryName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 8),
          Text("${(rating * 10).toStringAsFixed(2)} %",
              style: const TextStyle(color: Colors.black)),
          const SizedBox(height: 4),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: rating / 10,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
