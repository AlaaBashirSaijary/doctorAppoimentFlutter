import '../Style/consts.dart';

Widget HomeButton({width,hight,icon,title,onPressed}) {
  return Expanded(

    child: Container(
      width: width,
      height: hight,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25)
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset(icon,width: 26,),
       const SizedBox(height: 5,),
       Text(title,style: const TextStyle(
        fontFamily: semibold,
        color:darkFontGrey
       ),)
      ]),
    ),
  );
}
