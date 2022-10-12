// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:myapp/DataStore.dart';
import 'package:myapp/DatabaseHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Profile());
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  final firstNameController = TextEditingController();

  final middleNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailNameController = TextEditingController();

  final mobileController = TextEditingController();

  bool updateVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Profile"),
              backgroundColor: Color.fromARGB(255, 124, 41, 138),
            ),
            body: Container(
                color: Color.fromARGB(255, 124, 41, 138),
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(255, 255, 255, 1)),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'First Name',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hintText: 'First Name',
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: middleNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'Middle Name',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hintText: 'Middle Name',
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'Last Name',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hintText: 'Last Name',
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: emailNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'Email ',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hintText: 'Email ',
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: mobileController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'Mobile Number',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hintText: 'Mobile Number',
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              child: Btn("SAVE"),
                              onTap: () {
                                if (firstNameController.text.isNotEmpty) {
                                  saveData();
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => TaskWidget());

                                  firstNameController.clear();

                                  middleNameController.clear();

                                  lastNameController.clear();

                                  emailNameController.clear();

                                  mobileController.clear();
                                }
                              }),
                          GestureDetector(
                              child: Btn("HISTORY"),
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => TaskWidget());
                              }),
                        ],
                      ),
                    ],
                  ),
                ))));
  }

  static Container Btn(String btnTitle) {
    return Container(
      //  margin: EdgeInsets.only(left: 100, right: 100),
      width: 130,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 124, 41, 138),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Text(
          btnTitle,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void saveData() async {
    if (firstNameController.text.isNotEmpty) {
      var saveData = {
        DatabaseHelper.firstName: firstNameController.text,
        DatabaseHelper.lastName: lastNameController.text,
        DatabaseHelper.middleName: middleNameController.text,
        DatabaseHelper.email: emailNameController.text,
        DatabaseHelper.mobileNo: mobileController.text,
      };
      var id = await dbHelper.insertProfile(saveData);

      print(saveData);
    }
  }
}
