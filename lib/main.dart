import 'package:capstone_jobkro/admin/home_admin.dart';
import 'package:capstone_jobkro/user/home_user.dart';
import 'package:flutter/material.dart';
//admin features
/*
on home screen he can see the report of active user, deactivated users,see users
 */
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'JOBKRO',
    home: HomeUser(),
    // home: HomeAdmin(),
  ));
}
