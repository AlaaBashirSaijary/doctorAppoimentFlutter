import '../Style/consts.dart';

Widget CustomButton({onPressed,color,textColor,title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: golden,
      
      padding: const EdgeInsets.all(8)
    ),
    onPressed: onPressed, child: Text(title, style: TextStyle(
    color: textColor,
    fontFamily: bold,
  ),));
}
