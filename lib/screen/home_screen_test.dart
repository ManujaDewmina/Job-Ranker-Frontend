// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_ranker/reusable_widgets/reusable_widget.dart';
import 'package:job_ranker/screen/sign_in_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeCardIndex = 0;
  //var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    //String? email = currentUser?.email;
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
            ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: <Widget>[
              CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 1.0,
                    enlargeCenterPage: true,
                  ),
                  items: [
                    swapCard("Search Jobs","assert/images/1slider.jpg"),
                    swapCard("Rated job Details","assert/images/2slider.jpg"),
                    swapCard("Job Classifier","assert/images/3slider.jpg")
                  ]),
            ],
          ),
        ),
      ),
      drawer: appDrawer(context),
    );
  }
}