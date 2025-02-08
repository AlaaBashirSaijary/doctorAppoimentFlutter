import '../Style/consts.dart';

Widget bgWidet( {required Scaffold child}) {
  return Container(
decoration: BoxDecoration(
  image: DecorationImage(image: AssetImage(imgBackground2),fit: BoxFit.fill
),
),
child: child,
  );
}
