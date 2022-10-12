// ignore_for_file: prefer_const_constructors, avoid_print, prefer_typing_uninitialized_variables, must_be_immutable
import 'package:flutter/material.dart';
import 'package:myapp/DatabaseHelper.dart';

class TaskWidget extends StatefulWidget {
  var visibility;
  TaskWidget({
    Key? key,
    updateVisible,
  }) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  String firstName = '';
  String middleName = '';
  String lastName = '';
  String email = '';
  String mobile = '';
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(255, 124, 41, 138),
        child: Container(
            padding: EdgeInsets.all(10),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(255, 255, 255, 1)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FutureBuilder<List<dynamic>>(
                      future: dbHelper.getAllRecordProfile(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.data!.isNotEmpty) {
                          return Column(
                            children: [
                              SizedBox(
                                  height: 400,
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            inputDecorator(
                                                "First Name",
                                                snapshot.data![index]
                                                    ['first_name']),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            inputDecorator(
                                                "Middle Name",
                                                snapshot.data![index]
                                                    ['middle_name']),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            inputDecorator(
                                                "Last Name",
                                                snapshot.data![index]
                                                    ['last_name']),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            inputDecorator("Email",
                                                snapshot.data![index]['email']),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            inputDecorator(
                                                "Mobile Number",
                                                snapshot.data![index]
                                                    ['mobile_no']),
                                            SizedBox(
                                              height: 80,
                                            ),
                                          ],
                                        );
                                      })),
                              Center(
                                child: GestureDetector(
                                  child: Btn("DELETE"),
                                  onTap: () async {
                                    final id = await dbHelper.queryRowCount();
                                    final rowsDeleted =
                                        await dbHelper.delete(id!);
                                    print(
                                        'deleted $rowsDeleted row(s): row $id');
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(
                              'No Data !',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }
                      })
                ])));
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

  InputDecorator inputDecorator(label, text) {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(left: 12, right: 23, top: 23, bottom: 23),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
        labelText: label,
        hoverColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      child: Text(text),
    );
  }
}
