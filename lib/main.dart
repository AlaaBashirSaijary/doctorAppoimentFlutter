
import 'dart:io';

import 'package:doctorappoiment/Screen/AdminScreen/adminScreen.dart';
import 'package:doctorappoiment/Screen/splach_Screen/auth_creen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screen/HomeScreen/DoctorsListScreen.dart';
import 'Screen/splach_Screen/splach.dart';
import 'Style/colors.dart';
import 'Style/styeles.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme:const AppBarTheme(
            iconTheme: IconThemeData(
              color: darkFontGrey,
            ),
            backgroundColor: Colors.transparent,
          ),
          fontFamily: regular),
      home: SplachScreen(),
    );
  }
}
