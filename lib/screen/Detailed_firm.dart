import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_ranker/reusable_widgets/reusable_widget.dart';
import '../Utils/color_utils.dart';
import '../gateway/backend.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauges;

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
  var currentUser = FirebaseAuth.instance.currentUser;
  final String firmName;
  List<double> ratings = [0.0];
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
      yearCountData = yearCount
          .map((dynamic item) {
            Map<String, int> mappedItem = {
              'year': item['year'] ?? 0,
              'year_count': item['year_count'] ?? 0,
            };
            return mappedItem;
          })
          .take(10)
          .toList();
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

      double predicted_score =
          firmSentimentDetails['Predicted_Sentiments'] ?? 0.0;

      return [
        workLifeBalance,
        cultureValues,
        diversityInclusion,
        careerOpportunities,
        companyBenefits,
        seniorManagement,
        recommendToFriend,
        ceoApproval,
        predicted_score
      ];
    } catch (error) {
      print('Error fetching firm details: $error');
      return List.filled(9, 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor("1a3f49"),
        actions: [
          GestureDetector(
            onTap: () async {
              await addFavourite(currentUser!.uid, firmName);
              ScaffoldMessenger.of(context)
                  .showSnackBar(ackMessage('Added to favourites successfully!'));
            },
            child: const Row(children: [
              Text(
                'Add to favourite',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 5),
              Icon(Icons.add)
            ]),
          ),
        ],
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
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white24,
                  ));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  ratings = snapshot.data!;
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(FontAwesomeIcons.briefcase,
                              color: Colors.white),
                          const SizedBox(width: 10.0),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Wrap(
                              children: [
                                Text(
                                  firmName,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                          const SizedBox(height: 15),
                          _circleBar("Score for reviews", ratings[8]),
                          const SizedBox(height: 15),
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
                          SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                              labelRotation: -90,
                              labelStyle: const TextStyle(color: Colors.white),
                              majorGridLines: const MajorGridLines(width: 0),
                              minorGridLines: const MinorGridLines(width: 0),
                            ),
                            primaryYAxis: NumericAxis(
                              labelStyle: const TextStyle(color: Colors.white),
                              majorGridLines: const MajorGridLines(width: 0),
                              minorGridLines: const MinorGridLines(width: 0),
                            ),
                            title: ChartTitle(
                                text: 'Job Title vs Number of Reviews',
                                textStyle:
                                    const TextStyle(color: Colors.white)),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries>[
                              ColumnSeries<Map<String, dynamic>, String>(
                                  dataSource: titleCountData,
                                  xValueMapper:
                                      (Map<String, dynamic> data, _) =>
                                          data['job_title'].toString(),
                                  yValueMapper:
                                      (Map<String, dynamic> data, _) =>
                                          data['title_count'],
                                  dataLabelSettings:
                                      const DataLabelSettings(isVisible: true),
                                  color: Colors.green),
                            ],
                          ),
                          SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                              labelRotation: -90,
                              labelStyle: const TextStyle(color: Colors.white),
                              majorGridLines: const MajorGridLines(width: 0),
                              minorGridLines: const MinorGridLines(width: 0),
                            ),
                            primaryYAxis: NumericAxis(
                              labelStyle: const TextStyle(color: Colors.white),
                              majorGridLines: const MajorGridLines(width: 0),
                              minorGridLines: const MinorGridLines(width: 0),
                            ),
                            title: ChartTitle(
                                text: 'Year vs Number of Reviews',
                                textStyle:
                                    const TextStyle(color: Colors.white)),
                            legend: const Legend(isVisible: false),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries>[
                              ColumnSeries<Map<String, int>, String>(
                                  dataSource: yearCountData,
                                  xValueMapper: (Map<String, int> data, _) =>
                                      data['year'].toString(),
                                  yValueMapper: (Map<String, int> data, _) =>
                                      data['year_count'],
                                  dataLabelSettings:
                                      const DataLabelSettings(isVisible: true),
                                  color: Colors.green),
                            ],
                          ),
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
    return SizedBox(
      height: 150,
      width: 150,
      child: gauges.SfRadialGauge(
        axes: [
          gauges.RadialAxis(
            startAngle: 90,
            endAngle: 90,
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            axisLineStyle: gauges.AxisLineStyle(
              thickness: 0.15,
              color: hexStringToColor("1a3f49"),
              thicknessUnit: gauges.GaugeSizeUnit.factor,
            ),
            pointers: [
              gauges.RangePointer(
                color: Colors.green,
                animationType: gauges.AnimationType.ease,
                enableAnimation: true,
                cornerStyle: gauges.CornerStyle.bothCurve,
                width: 0.15,
                sizeUnit: gauges.GaugeSizeUnit.factor,
                value: (rating * 10),
              ),
            ],
            annotations: <gauges.GaugeAnnotation>[
              gauges.GaugeAnnotation(
                positionFactor: 0.1,
                angle: 90,
                widget: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '$topic\n',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${(rating * 10).toStringAsFixed(2)} %',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(String categoryName, double rating) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: hexStringToColor("244e54"),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Text(categoryName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 13)),
          const SizedBox(height: 8),
          Text("${(rating * 10).toStringAsFixed(2)} %",
              style: const TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: hexStringToColor("1a3f49"),
            ),
            child: gauges.SfLinearGauge(
              orientation: gauges.LinearGaugeOrientation.horizontal,
              minimum: 0,
              maximum: 100,
              showLabels: false,
              showTicks: false,
              showAxisTrack: false,
              isMirrored: true,
              barPointers: [
                gauges.LinearBarPointer(
                  thickness: 9,
                  enableAnimation: true,
                  value: rating * 10,
                  edgeStyle: gauges.LinearEdgeStyle.bothCurve,
                  position: gauges.LinearElementPosition.inside,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
