

import '../Style/consts.dart';
Widget applogowidget() {
  return Container(
   // width:MediaQuery.of(context).size.width * 0.8,
    width: 350,
    height: 350,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(360),
    ),
    clipBehavior: Clip.antiAlias,
    child:Image.asset(icAppLogo) ,);
}
