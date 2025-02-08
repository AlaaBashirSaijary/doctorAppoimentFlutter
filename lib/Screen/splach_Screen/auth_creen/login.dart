import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/authController.dart';
import '../../../Style/consts.dart';
import '../../../widget_common/bg_widget.dart';
import '../../../widget_common/Buttun_wideget.dart';
import '../../../widget_common/colum_widget.dart';
import '../../HomeScreen/homeScreen.dart';
import 'signup.dart';
import 'signuppDoctor.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidet(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(icAppLogo),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Login Screen",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: whiteColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Obx(
                    () => Column(
                      children: [
                        CustomTextfield(
                          title: email,
                          hiteTitle: emaihint,
                          isPass: false,
                          controller: controller.emailController,
                        ),
                        CustomTextfield(
                          title: password,
                          hiteTitle: passwordhint,
                          isPass: true,
                          controller: controller.passwordController,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(forgetPassword),
                          ),
                        ),
                        controller.isLoading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : CustomButton(
                                color: redColor,
                                title: login,
                                textColor: whiteColor,
                                onPressed: () async {
                                  controller.isLoading(true);
                                  await controller.loginMethod();
                                   // Get.offAll(() => const HomeScrenn());
                                  //.catchError((_) {
                                  //  controller.isLoading(false);
                                //  });
                                },
                              ),
                        const Text(
                          CreatedNewAccont,
                          style: TextStyle(color: fontGrey),
                        ),
                        CustomButton(
                          color: lightgolden,
                          title: SignupDoctor,
                          textColor: redColor,
                          onPressed: () {
                            Get.to(() => const SignupScrenDoctor());
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomButton(
                          color: lightgolden,
                          title: SignupPatint,
                          textColor: redColor,
                          onPressed: () {
                            Get.to(() => const SignupScren());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
