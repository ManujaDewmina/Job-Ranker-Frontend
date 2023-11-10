import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Utils/color_utils.dart';
import 'package:job_ranker/reusable_widgets/reusable_widget.dart';

import '../gateway/backend.dart';
import 'Detailed_firm.dart';

class ClassifierViewScreen extends StatefulWidget {
  final bool workLifeBalance;
  final bool cultureValues;
  final bool diversityInclusion;
  final bool careerOpp;
  final bool compBenefits;
  final bool seniorMgmt;
  final bool recommend;
  final bool ceoApprov;
  final bool reviewRating;
  const ClassifierViewScreen(
      this.workLifeBalance,
      this.cultureValues,
      this.diversityInclusion,
      this.careerOpp,
      this.compBenefits,
      this.seniorMgmt,
      this.recommend,
      this.ceoApprov,
      this.reviewRating,
      {Key? key})
      : super(key: key);

  @override
  State<ClassifierViewScreen> createState() => _ClassifierViewScreenState(
      workLifeBalance,
      cultureValues,
      diversityInclusion,
      careerOpp,
      compBenefits,
      seniorMgmt,
      recommend,
      ceoApprov,
      reviewRating);
}

class _ClassifierViewScreenState extends State<ClassifierViewScreen> {
  final bool workLifeBalance;
  final bool cultureValues;
  final bool diversityInclusion;
  final bool careerOpp;
  final bool compBenefits;
  final bool seniorMgmt;
  final bool recommend;
  final bool ceoApprov;
  final bool reviewRating;
  _ClassifierViewScreenState(
      this.workLifeBalance,
      this.cultureValues,
      this.diversityInclusion,
      this.careerOpp,
      this.compBenefits,
      this.seniorMgmt,
      this.recommend,
      this.ceoApprov,
      this.reviewRating);

  late Future<List<dynamic>> itemsFuture;

  @override
  void initState() {
    super.initState();
    itemsFuture = fetchSortedFirmAverages(
        workLifeBalance,
        cultureValues,
        diversityInclusion,
        careerOpp,
        compBenefits,
        seniorMgmt,
        recommend,
        ceoApprov,
        reviewRating);
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
          gradient: LinearGradient(
            colors: [
              hexStringToColor("1a3f49"),
              hexStringToColor("244e54"),
              hexStringToColor("4EB3A4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Classifier Results',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(1.0),
                  child: Column(
                    children: [
                      FutureBuilder<List<dynamic>>(
                        future: itemsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<dynamic> items = snapshot.data!;
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  String companyName = items[index][0];
                                  double rating = items[index][1];
                                  rating = double.parse(rating.toStringAsFixed(3));
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: hexStringToColor("408994")
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        companyName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Total Score : ${rating.toString()}",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      leading: const Icon(
                                        FontAwesomeIcons.briefcase,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailedFirmScreen(
                                                    companyName),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: appDrawer(context),
    );
  }
}
