import 'dart:convert';

import 'package:capstone_jobkro/constant.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:http/http.dart' as http;
class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

//userName,district,mobileNumber,profession

class _RegisterUserState extends State<RegisterUser> {

  List<String> district=['test1','test2','test3','test4','test5','test4'];
  List<String> profession=['profession1','profession2','profession3'];
  var hintForDistrict="Choose Location";
  var hintForProfession="Choose Profession";
  TextEditingController mn=TextEditingController();
  TextEditingController n=TextEditingController();

  var resCode;

  Future<http.Response> RegisterUser(name,mobile,profession,location) async{
    var httpBody=jsonEncode({
      "userName":name,
      "mobileNumber":mobile,
      "profession":profession,
      "district":location
    });
    try{
      await http.post(createUser,headers: header,body: httpBody).then((value){
        resCode=jsonDecode(value.body)['response_code'].toString();
      });
    }catch(err){
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.width/4,),
              TextField(
                controller: n,
                decoration: InputDecoration(
                  hintText: 'Name'
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: mn,
                decoration: InputDecoration(
                  hintText: 'Mobile'
                ),
              ),
              SizedBox(height: 15,),
              DropdownButton(
                hint: Text(hintForProfession),
                isExpanded: true,
                items: profession.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (v){
                  setState(() {
                    hintForProfession=v;
                  });
                },
              ),
              SizedBox(height: 15,),
              DropdownButton(
                hint: Text(hintForDistrict),
                isExpanded: true,
                items: district.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (v){
                  setState(() {
                    hintForDistrict=v;
                  });
                },
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () async{
                  // todo call create user api here
                  String mobile=mn.text.trim();
                  String name=n.text.trim();
                  if(mobile==null || mobile.length!=10 || !isNumeric(mobile) ){
                    //todo show error--invalid mobile number
                  }
                  else if(name==null || name.isEmpty){
                    //todo error -- invalid name
                  }else if (hintForDistrict=='' || hintForProfession==''){
                    //todo show error - invalid profession or location
                  }else{
                    //call create user api
                    await RegisterUser(name, mobile, hintForProfession, hintForDistrict);
                    if(resCode=="200"){
                      print('registered');
                      n.clear();
                      mn.clear();
                      //todo show sussfully resgisterd
                    }else if(resCode=="202"){
                      //todo already resitered
                      print('already registered');
                    }else{
                      //todo error
                      print('failed registered');
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/3,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green
                  ),
                  child: Center(
                    child: Text('Register',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
