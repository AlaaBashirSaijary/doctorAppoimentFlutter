
import '../../../Style/consts.dart';

Widget detailsCart({width,String? count,String? title,}) {
  return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(25)),
      width:width,
      height: 80,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$count',
            style:
                TextStyle(fontFamily: bold, fontSize: 16, color: darkFontGrey),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '$title',
            style: TextStyle(
                //fontFamily:bold,
                color: darkFontGrey),
          ),
        ],
      ));
}
