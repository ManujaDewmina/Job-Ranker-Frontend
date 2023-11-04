import 'package:flutter/material.dart';
import 'package:job_ranker/reusable_widgets/reusable_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:job_ranker/screen/rated_job_details_screen.dart';
import '../Utils/color_utils.dart';
import 'classifier_screen.dart';
import 'new_review_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeCardIndex = 0;

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
            child: Column(
              children: <Widget>[
                CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 1.0,
                      enlargeCenterPage: true,
                    ),
                    items: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewReviewScreen(),
                            ),
                          );
                        },
                        child: swapCard("Review Jobs", "assert/images/1slider.jpg"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailsScreen(),
                            ),
                          );
                        },
                        child: swapCard("Rated job Details", "assert/images/2slider.jpg"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ClassifierScreen(),
                            ),
                          );
                        },
                        child: swapCard("Job Classifier", "assert/images/3slider.jpg"),
                      ),
                    ]),
                const SizedBox(
                  height: 30,
                ),
                const Image(
                  image: AssetImage('assert/images/app_logo.png'),
                  height: 250,
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
