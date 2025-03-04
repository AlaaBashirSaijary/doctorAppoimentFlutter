import 'package:doctorappoiment/Screen/HomeScreen/AppoimentinDoctor.dart';
import 'package:doctorappoiment/Screen/HomeScreen/Home.dart';
import 'package:doctorappoiment/Screen/HomeScreen/payment.dart';
import 'package:doctorappoiment/Style/consts.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import 'PatientDashboardScreen.dart';

class HomeScrenn extends StatelessWidget {
  const HomeScrenn({super.key});

  @override
  Widget build(BuildContext context) {
     var controller = Get.put(HomeController());
    var nevbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: 'Booking'),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];
    var navBody = [
    Home(),BookAppointmentScreen(),PaymentScreen(),PatientDashboardScreen()
    ];

    return Scaffold(
      body: Column(
        children:[Obx(()=>
         Expanded(
            child: navBody.elementAt(controller.curentNavIndex.value),
          ),
        ),]
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.curentNavIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle: TextStyle(fontFamily: semibold),
          backgroundColor: whiteColor,
          type: BottomNavigationBarType.fixed,
          items: nevbarItem,
          onTap: (Value) {
            controller.curentNavIndex.value = Value;
          },
        ),
      ),
    );
  }
}