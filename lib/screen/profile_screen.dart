import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_ranker/gateway/backend.dart';
import '../Utils/color_utils.dart';
import 'package:job_ranker/reusable_widgets/reusable_widget.dart';

import 'Detailed_firm.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var currentUser = FirebaseAuth.instance.currentUser;
  List<dynamic>? userDetails;
  List<dynamic>? favouritesDetails;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
    _loadfavouritesDetails();
  }

  Future<void> _loadfavouritesDetails() async {
    try {
      List<dynamic> data = await fetchFavouritesDetails(currentUser?.uid ?? '');
      setState(() {
        favouritesDetails = data;
      });
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> _loadUserDetails() async {
    try {
      List<dynamic> data = await fetchUserDetails(currentUser?.uid ?? '');
      setState(() {
        userDetails = data;
      });
    } catch (e) {
      print('Error fetching user details: $e');
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Text(
                  'User Dashboard',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                if (userDetails != null)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: hexStringToColor("1a3f49"),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'User Name:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${userDetails![0]['username']}',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: hexStringToColor("1a3f49"),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Email:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${userDetails![0]['useremail']}',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'User Favourites',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (favouritesDetails != null)
                  ListView.builder(
                    itemCount: favouritesDetails!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var firm = favouritesDetails![index];
                      return Container(
                        decoration: BoxDecoration(
                          color: hexStringToColor("408994").withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            '${firm['firm']}',
                            style: const TextStyle(color: Colors.black),
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
                                    DetailedFirmScreen('${firm['firm']}'),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                const SizedBox(
                  height: 20,
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
