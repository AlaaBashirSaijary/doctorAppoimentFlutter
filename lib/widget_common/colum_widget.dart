import '../Style/consts.dart';

Widget CustomTextfield({String? title, String? hiteTitle, controller, isPass}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '$title',
          style: TextStyle(
            color: redColor,
            fontFamily: semibold,
            fontSize: 16,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: TextFormField(
          obscureText: isPass,
          controller: controller,
          decoration: InputDecoration(
              isDense: true,
              hintText: hiteTitle,
              helperStyle: const TextStyle(
                fontFamily: semibold,
                color: fontGrey,
              ),
              fillColor: lightGrey,
              filled: true,
              border: InputBorder.none,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: redColor))),
        ),
      ),
    ],
  );
}

class $title {}
