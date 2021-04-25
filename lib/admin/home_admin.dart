import 'package:capstone_jobkro/admin/getUserScreen.dart';
import 'package:capstone_jobkro/admin/updateStatusSreen.dart';
import 'package:flutter/material.dart';
class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}
class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Welcome'),
      ),
      body: Center(
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  //todo call see user api
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GetUserScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue
                  ),
                  child: Center(
                    child: Text('See User',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width/4,),
              InkWell(
                onTap: (){
                  //todo call the get user by status api here
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateStatusScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green
                  ),
                  child: Center(
                    child: Text('Change Status',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
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
