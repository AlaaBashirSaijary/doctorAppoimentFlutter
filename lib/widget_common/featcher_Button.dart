import '../Style/consts.dart';

Widget FeatureButton({String? title,icon,}) {
  return Container(
    width: 200,
    margin: EdgeInsets.symmetric(horizontal: 4),
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(20),
        boxShadow: [
                   BoxShadow(
        color: Colors.grey.withOpacity(0.5), // لون الظل
        spreadRadius: 2, // مدى انتشار الظل
        blurRadius: 5, // مدى تلاشي الظل
        offset: Offset(0, 3), // موضع الظل
      ),
                ],
      ),
    clipBehavior: Clip.antiAlias,

    child: Row(
      children: [
        Image.asset(icon,width: 60,fit: BoxFit.fill,),
        const SizedBox(
          width: 10,
        ),
        Text(
          title!,
          style: TextStyle(fontFamily: semibold, color: darkFontGrey),
        )
      ],
    ),
  );
}
