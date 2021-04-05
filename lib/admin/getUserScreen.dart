import 'dart:convert';
import 'package:capstone_jobkro/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class GetUserScreen extends StatefulWidget {
  var isUser;
  GetUserScreen({this.isUser});
  @override
  _GetUserScreenState createState() => _GetUserScreenState();
}

class _GetUserScreenState extends State<GetUserScreen> {
  List<String> district = [];
  var d = new Map();
  bool filterFlag = false;
  var hintForChooseDistrict = "Choose District";

  @override
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }

  var resCode;
  var userData;

  Future<http.Response> getUser() async {
    try {
      await http.get(getAllUser, headers: header).then((user) {
        print(jsonDecode(user.body));
        resCode = jsonDecode(user.body)['response_code'].toString();
        if (resCode == "200") {
          userData = jsonDecode(user.body)['data'];
          userData.forEach((ele) {
            // print(ele['district']);
            d[ele['district']] = true;
          });
          // print(d);
          d.forEach((key, value) {
            district.add(key);
          });
        }
        setState(() {});
      });
    } catch (err) {
      print(err);
    }
  }

  _makingPhoneCall(url) async {
    // const url = 'tel:9876543210';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: Colors.orange,
        /*actions: [
          InkWell(
            onTap: () {
              if (filterFlag) {
                setState(() {
                  filterFlag = false;
                });
              } else {
                setState(() {
                  filterFlag = true;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.filter_list_alt,
                color: Colors.white,
              ),
            ),
          )
        ],*/
      ),
      body: Center(
        child: userData != null
            ? Column(
                children: [
                  filterFlag
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 6,
                          child: DropdownButton(
                            hint: Text(hintForChooseDistrict),
                            isExpanded: true,
                            items: district.map((e) {
                              return DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (v) {
                              setState(() {
                                hintForChooseDistrict = v;
                              });
                            },
                          ))
                      : SizedBox(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        return widget.isUser==null?Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: InkWell(
                            onTap: () {
                              //todo show the persons details
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                              color: userData[index]['isApproved']?Colors.green[400]:Colors.red[400]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${userData[index]['userName']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Spacer(),
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
                                        SizedBox(width: 10,),
                                        Text(userData[index]['profession']),
                                        Spacer(),
                                        Text(userData[index]['district']),
                                        Spacer(),
                                        Text(userData[index]
                                        ['isApproved']
                                            ? 'Approved'
                                            : 'Not Approved')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):userData[index]['isApproved']?Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: InkWell(
                            onTap: () {
                              //todo show the persons details
                              Alert(
                                context: context,
                                type: AlertType.info,
                                title: "Message",
                                desc: "Are you sure u want to call ${userData[index]['userName']}",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "No",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      //todo make the code for calling a person
                                      _makingPhoneCall('tel:'+userData[index]['mobileNumber']);
                                    },
                                    width: 120,
                                  )
                                ],
                              ).show();

                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: userData[index]['isApproved']?Colors.green[400]:Colors.red[400]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${userData[index]['userName']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Spacer(),
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
                                        SizedBox(width: 10,),
                                        Text(userData[index]['profession']),
                                        Spacer(),
                                        Text(userData[index]['district']),
                                        Spacer(),
                                        Text(userData[index]
                                        ['isApproved']
                                            ? 'Approved'
                                            : 'Not Approved')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):SizedBox();
                      },
                    ),
                  )
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  filteredBylocation(dataUser){

  }

}