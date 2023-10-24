import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Utils/color_utils.dart';
import '../screen/home_screen_test.dart';
import '../screen/rated_job_details_screen.dart';
import '../screen/sign_in_screen.dart';

Image logoWidget(String imageName){
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 150,
    height: 150,
    color: Colors.white,
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType, TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(
        color: Colors.white.withOpacity(0.9)
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.3)
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
              width: 0,
              style:  BorderStyle.none
          )
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

void setState(Null Function() param0) {
  obscureText: false;
}

Container signInSignUpButton(BuildContext context, String text1, Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(210, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states){
            if(states.contains(MaterialState.pressed)){
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20))
          )
      ),

      child: Text(
        text1,
        style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16
        ),
      ),
    ),
  );
}

SnackBar errorMessage(String msg){
  return SnackBar(
    content: Container(
        padding: const EdgeInsets.all(16),
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            const Text("ERROR",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            Text(msg,
              style: const TextStyle(color: Colors.black54,fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )
    ),
    behavior: SnackBarBehavior.fixed,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

SnackBar ackMessage(String msg){
  return SnackBar(
    content: Container(
        padding: const EdgeInsets.all(16),
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            const Text("Info",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            Text(msg,
              style: const TextStyle(color: Colors.black54,fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )
    ),
    behavior: SnackBarBehavior.fixed,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

Drawer appDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: hexStringToColor("244e54"),
    child: ListView(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(
              color: hexStringToColor("244e54"),
            ),
            child: const Column(
              children: [
                Text(
                  'JOB RANKER',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Image(
                  image: AssetImage('assert/images/Logo.png'),
                  height: 100,
                ),
              ],
            )),
        ListTile(
          leading: const Icon(
            FontAwesomeIcons.circleUser,
            color: Colors.white,
          ),
          title: const Text(
            'My Profile',
            style: TextStyle(
              color: Colors.white, // White text color
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        ListTile(
          leading: const Icon(
            FontAwesomeIcons.magnifyingGlassPlus,
            color: Colors.white,
          ),
          title: const Text(
            'Search Jobs',
            style: TextStyle(
              color: Colors.white, // White text color
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.workspace_premium,
            color: Colors.white,
          ),
          title: const Text(
            'Rated job Details',
            style: TextStyle(
              color: Colors.white, // White text color
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DetailsScreen()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.video_label,
            color: Colors.white,
          ),
          title: const Text(
            'Job Classifier',
            style: TextStyle(
              color: Colors.white, // White text color
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          title: const Text(
            'LogOut',
            style: TextStyle(
              color: Colors.white, // White text color
            ),
          ),
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
            });
          },
        ),
      ],
    ),
  );
}

Card swapCard(String topic, String imageUrl) {
  return Card(
    elevation: 10,
    color: Colors.transparent,
    shape: const RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  child: SizedBox(
    width: 250,
    height: 200,
  child: Stack(
    children: [
    Opacity(
      opacity: 0.5,
      // Image widget as the background
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imageUrl, // Provide the asset image path
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover, // Adjust the fit based on your image requirements
          ),
      ),
    ),
      // Centered text widget on top of the image
      Center(
        child: Text(
          topic,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    ],
  )
  )
  );
}