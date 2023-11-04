import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Utils/color_utils.dart';
import '../gateway/backend.dart';
import 'Detailed_firm.dart';
import 'package:job_ranker/reusable_widgets/reusable_widget.dart';
import 'add_review_screen.dart';

class NewReviewScreen extends StatefulWidget {
  const NewReviewScreen({Key? key}) : super(key: key);

  @override
  State<NewReviewScreen> createState() => _NewReviewScreenState();
}

class _NewReviewScreenState extends State<NewReviewScreen> {
  late Future<List<String>> _itemsFuture;
  final _controller = TextEditingController();
  StreamController<List<String>> _streamController =
  StreamController<List<String>>();

  @override
  void initState() {
    super.initState();
    _itemsFuture = fetchFirmNames();
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String query = _controller.text.toLowerCase();
    _itemsFuture.then((items) {
      List<String> searchResults =
      items.where((item) => item.toLowerCase().contains(query)).toList();
      _streamController.add(searchResults);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _streamController.close();
    super.dispose();
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
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 2.0),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<List<String>>(
                    stream: _streamController.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ) {
                        return FutureBuilder<List<String>>(
                          future: _itemsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              List<String> items = snapshot.data!;
                              return ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
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
                                        items[index],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      leading: const Icon(
                                        FontAwesomeIcons.briefcase,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviewScreen(items[index]))
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text('New company - No previous data for this company'),
                                    const SizedBox(height: 60),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviewScreen(_controller.text)));
                                      },
                                      child: const Text('Select Firm'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      } else if(snapshot.data!.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('New company - No previous data for this company'),
                              const SizedBox(height: 60),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviewScreen(_controller.text)));
                                },
                                child: const Text('Select Firm'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        List<String> filteredItems =
                        snapshot.data as List<String>;
                        return ListView.builder(
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color:
                                hexStringToColor("408994").withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  filteredItems[index],
                                  style: const TextStyle(color: Colors.black),
                                ),
                                leading: const Icon(
                                  FontAwesomeIcons.briefcase,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviewScreen(filteredItems[index]))
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
      drawer: appDrawer(context),
    );
  }
}
