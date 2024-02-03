import 'package:flutter/material.dart';
import '../Utils/color_utils.dart';
import 'package:job_ranker/reusable_widgets/reusable_widget.dart';

import 'classifier_view_screen.dart';

class ClassifierScreen extends StatefulWidget {
  const ClassifierScreen({Key? key}) : super(key: key);

  @override
  State<ClassifierScreen> createState() => _ClassifierScreenState();
}

class _ClassifierScreenState extends State<ClassifierScreen> {
  bool workLifeBalance = false;
  bool cultureValues = false;
  bool diversityInclusion = false;
  bool careerOpp = false;
  bool compBenefits = false;
  bool seniorMgmt = false;
  bool recommend = false;
  bool ceoApprov = false;
  bool reviewRating = false;

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
                'Select your classifier categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: Text('Review Ratings'),
                      value: reviewRating,
                      onChanged: (bool? value) {
                        setState(() {
                          reviewRating = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Work Life Balance'),
                      value: workLifeBalance,
                      onChanged: (bool? value) {
                        setState(() {
                          workLifeBalance = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Culture Values'),
                      value: cultureValues,
                      onChanged: (bool? value) {
                        setState(() {
                          cultureValues = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Diversity & Inclusion'),
                      value: diversityInclusion,
                      onChanged: (bool? value) {
                        setState(() {
                          diversityInclusion = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Career Opportunities'),
                      value: careerOpp,
                      onChanged: (bool? value) {
                        setState(() {
                          careerOpp = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Compensation & Benefits'),
                      value: compBenefits,
                      onChanged: (bool? value) {
                        setState(() {
                          compBenefits = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Senior Management'),
                      value: seniorMgmt,
                      onChanged: (bool? value) {
                        setState(() {
                          seniorMgmt = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Recommendation'),
                      value: recommend,
                      onChanged: (bool? value) {
                        setState(() {
                          recommend = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('CEO Approval'),
                      value: ceoApprov,
                      onChanged: (bool? value) {
                        setState(() {
                          ceoApprov = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (!(workLifeBalance || cultureValues || diversityInclusion || careerOpp ||
                      compBenefits || seniorMgmt || recommend || ceoApprov || reviewRating)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        errorMessage("Select prefer categories")
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassifierViewScreen(
                          workLifeBalance,
                          cultureValues,
                          diversityInclusion,
                          careerOpp,
                          compBenefits,
                          seniorMgmt,
                          recommend,
                          ceoApprov,
                          reviewRating,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: hexStringToColor("1a3f49"),
                ),
                child: const Text('Send to classifier'),
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
