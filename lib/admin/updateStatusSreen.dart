import 'dart:convert';

import 'package:flutter/material.dart';

// import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class UpdateStatusScreen extends StatefulWidget {
  @override
  _UpdateStatusScreenState createState() => _UpdateStatusScreenState();
}

class _UpdateStatusScreenState extends State<UpdateStatusScreen> {
  @override
  void initState() {
    getUser(false);
    // TODO: implement initState
    super.initState();
  }

  var resCode;
  var userData;

  Future<http.Response> getUser(status) async {
    var httpBody = jsonEncode({"isApproved": status});
    try {
      await http
          .post(getUserByStatus, headers: header, body: httpBody)
          .then((user) {
        print(jsonDecode(user.body));
        resCode = jsonDecode(user.body)['response_code'].toString();
        if (resCode == "200") {
          userData = jsonDecode(user.body)['data'];
        }
        setState(() {});
      });
    } catch (err) {
      print(err);
    }
  }

  // var userData1;
  var resCode1;

  Future<http.Response> updateUserStatus(mobileNumber, isApproved) async {
    var httpBody =
        jsonEncode({"mobileNumber": mobileNumber, "isApproved": isApproved});
    try {
      await http
          .post(updateStatus, headers: header, body: httpBody)
          .then((user) {
        resCode1 = jsonDecode(user.body)['response_code'].toString();
        // if (resCode1 == "200") {
        //   userData1 = jsonDecode(user.body)['data'];
        // }
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: userData != null
            ? Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: userData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[100]),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                // SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${userData[index]['userName']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    // Spacer(),
                                    Row(
                                      children: [
                                        Icon(Icons.call),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          userData[index]['mobileNumber']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.work),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(userData[index]['profession']),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(userData[index]['district']),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap:() async{
                                        await updateUserStatus(userData[index]['mobileNumber'], true);
                                        if(resCode1=="200"){
                                          await getUser(false);
                                        }
                                        print('hey');
                                      },
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green[400]
                                        ),
                                        child: Center(
                                          child:Icon(Icons.check_box,color: Colors.white,size: 30,),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
