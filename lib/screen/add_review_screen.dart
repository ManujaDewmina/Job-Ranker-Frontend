import 'package:flutter/material.dart';
import 'package:job_ranker/gateway/backend.dart';
import 'package:job_ranker/reusable_widgets/reusable_widget.dart';
import '../Utils/color_utils.dart';
import 'home_screen_test.dart';

class AddReviewScreen extends StatefulWidget {
  final String firmName;
  const AddReviewScreen(this.firmName, {Key? key}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState(firmName);
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final String firmName;
  _AddReviewScreenState(this.firmName);
  double _workLifeBalanceRating = 0;
  double _cultureValuesRating = 0;
  double _diversityInclusionRating = 0;
  double _careerOppRating = 0;
  double _compBenefitsRating = 0;
  double _seniorMgmtRating = 0;
  double _recommendRating = 0;
  double _ceoApprovRating = 0;
  double _outlookRating = 0;

  TextEditingController jobTitleController = TextEditingController();
  TextEditingController headlineController = TextEditingController();
  TextEditingController prosController = TextEditingController();
  TextEditingController consController = TextEditingController();

  Future<void> _submitReview() async {
    String jobTitle = jobTitleController.text;
    String headline = headlineController.text;
    String pros = prosController.text;
    String cons = consController.text;

    try {
      await sendFirmReviewData(
        firmName,
        jobTitle,
        _workLifeBalanceRating,
        _cultureValuesRating,
        _diversityInclusionRating,
        _careerOppRating,
        _compBenefitsRating,
        _seniorMgmtRating,
        _recommendRating,
        _ceoApprovRating,
        _outlookRating,
        headline,
        pros,
        cons,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(ackMessage('Review submitted successfully!'));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit review. Error: $error')));
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
                  'Add Your Review',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Firm Name : $firmName',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: jobTitleController,
                  decoration: const InputDecoration(
                    hintText: 'Job Title',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: headlineController,
                  decoration: const InputDecoration(
                    hintText: 'Headline',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: prosController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Pros',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: consController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Cons',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                    color: hexStringToColor("1a3f49"),
                    elevation: 4,
                    margin: const EdgeInsets.all(0.1),
                    child: Column(children: [
                      buildRatingSlider(
                          'Work-Life Balance', _workLifeBalanceRating,
                          (newValue) {
                        setState(() {
                          _workLifeBalanceRating = newValue;
                        });
                      }),
                      buildRatingSlider('Culture Values', _cultureValuesRating,
                          (newValue) {
                        setState(() {
                          _cultureValuesRating = newValue;
                        });
                      }),
                      buildRatingSlider(
                          'Diversity & Inclusion', _diversityInclusionRating,
                          (newValue) {
                        setState(() {
                          _diversityInclusionRating = newValue;
                        });
                      }),
                      buildRatingSlider(
                          'Career Opportunities', _careerOppRating, (newValue) {
                        setState(() {
                          _careerOppRating = newValue;
                        });
                      }),
                      buildRatingSlider(
                          'Compensation & Benefits', _compBenefitsRating,
                          (newValue) {
                        setState(() {
                          _compBenefitsRating = newValue;
                        });
                      }),
                      buildRatingSlider('Senior Management', _seniorMgmtRating,
                          (newValue) {
                        setState(() {
                          _seniorMgmtRating = newValue;
                        });
                      }),
                      buildRatingSlider(
                          'Recommend to a Friend', _recommendRating,
                          (newValue) {
                        setState(() {
                          _recommendRating = newValue;
                        });
                      }),
                      buildRatingSlider('CEO Approval', _ceoApprovRating,
                          (newValue) {
                        setState(() {
                          _ceoApprovRating = newValue;
                        });
                      }),
                      buildRatingSlider('Outlook', _outlookRating, (newValue) {
                        setState(() {
                          _outlookRating = newValue;
                        });
                      }),
                    ])),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hexStringToColor("1a3f49"),
                  ),
                  child: const Text('Submit Review'),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      drawer: appDrawer(context),
    );
  }

  Widget buildRatingSlider(
      String label, double rating, ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          SliderTheme(
            data: const SliderThemeData(
              trackHeight: 8.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
            ),
            child: Slider(
              value: rating,
              onChanged: onChanged,
              min: 0,
              max: 5,
              divisions: 5,
              label: rating.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
