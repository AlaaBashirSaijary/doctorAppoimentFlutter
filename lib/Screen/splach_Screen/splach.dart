import 'dart:async';

import 'package:get/get.dart';
import '../../Style/consts.dart';
//import 'package:newshop/viwes/home_Screen/homeScreen.dart';
import '../../widget_common/applogo_widget.dart';

import 'auth_creen/login.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  ChangeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
                Get.to(() => const Loginscreen());

      //
     /* auth.authStateChanges().listen((User? user) {
        if(user==null && mounted){
          Get.to(() => const Loginscreen());
        }else{
          Get.to(() => const Homescreen());
        }
      });*/
    });
  }

  @override
  void initState() {
    ChangeScreen();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              icSplashBg,
              width: 300,
            ),
          ),
          applogowidget(),
         const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Booking With Doctors',
              style: TextStyle(
                  fontFamily: regular,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }
}
