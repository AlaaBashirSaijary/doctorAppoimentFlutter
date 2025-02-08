import 'package:doctorappoiment/Screen/HomeScreen/Home.dart';
import 'package:doctorappoiment/Screen/profile_Screen/prfile.dart';
import 'package:doctorappoiment/Style/consts.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

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
          label: category),
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
    Home(),Profile()
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