import 'package:doctorappoiment/Screen/profile_Screen/edit_profile.dart';
import 'package:get/get.dart';


import '../../Style/consts.dart';
import '../../Style/lists.dart';
import '../../controller/Profile_Conteroller.dart';
import '../../controller/authController.dart';
import '../../widget_common/bg_widget.dart';
import '../splach_Screen/auth_creen/login.dart';
import 'componets/details_Button.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidet(
        child: Scaffold(
            body: StreamBuilder(
               // stream: Firebaseservices.getUser(curentUser!.uid),
               builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else {
                    var docs;
                    var data = snapshot.data!.docs[0];
                    return SafeArea(
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () {
                                        controller.nameController.text = data['name'];
                                        controller.passController.text=data['password'];
                                        Get.to(() =>  EditProfile(data:data,));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: whiteColor,
                                      ))),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(

                                children: [
                                  data['imageUrl']==''?
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(360),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.asset(
                                        imgProfile2,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )):
                                       Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(360),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.network(
                                        data['imageUrl'],
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                       data['name']==''?
                                     Text(
                                       'Alaa',
                                        style: TextStyle(
                                            fontFamily: semibold,
                                            color: whiteColor),
                                      ) : Text(
                                       '${data['name']}',
                                        style: TextStyle(
                                            fontFamily: semibold,
                                            color: whiteColor),
                                      ),
                                       data['email']==''?
                                        Text(
                                       'alaa@mail.com',
                                        style: TextStyle(
                                            fontFamily: semibold,
                                            color: whiteColor),
                                      ):
                                      Text(
                                         '${data['email']}',
                                        style: TextStyle(
                                            fontFamily: semibold,
                                            color: whiteColor),
                                      ),
                                    ],
                                  )),
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: whiteColor)),
                                      onPressed: () async {
                                        await Get.put(AuthController())
                                            .signoutMethod('');
                                        Get.offAll(() => const Loginscreen());
                                      },
                                      child: Text(
                                        "LogOut",
                                        style: TextStyle(
                                            fontFamily: semibold,
                                            color: whiteColor),
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  detailsCart(
                                      count:  data['cart_count']==''?'00':data['cart_count'],
                                      title: 'in your Cart',
                                      width: MediaQuery.sizeOf(context).width /
                                          3.4),
                                  detailsCart(
                                      count: data['wishList_count']==''?'675':data['wishList_count'] ,
                                      title: 'in your WishList',
                                      width: MediaQuery.sizeOf(context).width /
                                          3.4),
                                  detailsCart(
                                      count: data['order_count']==''?'123':data['order_count'],
                                      title: ' your Orders',
                                      width: MediaQuery.sizeOf(context).width /
                                          3.4),
                                ],
                              ),
                            ),
                            Container(
                              color: redColor,
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), // لون الظل
                                        spreadRadius: 2, // مدى انتشار الظل
                                        blurRadius: 5, // مدى تلاشي الظل
                                        offset: Offset(0, 3), // موضع الظل
                                      ),
                                    ],
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(25)),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                margin: EdgeInsets.all(12),
                                clipBehavior: Clip.antiAlias,
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        splashColor: whiteColor,
                                        leading: Image.asset(
                                          ProfileButtonIcon[index],
                                          width: 22,
                                        ),
                                        title: Text(
                                          ProfileList[index],
                                          style: TextStyle(
                                              fontFamily: semibold,
                                              color: darkFontGrey),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, int index) {
                                      return Divider(
                                        color: lightGrey,
                                      );
                                    },
                                    itemCount: ProfileButtonIcon.length),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                })));
  }
}

class QuerySnapshot {
  var docs;
}
