import 'package:get/get.dart';
import '../../../Style/consts.dart';
import '../../../controller/authController.dart';
import '../../../widget_common/Buttun_wideget.dart';
import '../../../widget_common/bg_widget.dart';
import '../../../widget_common/colum_widget.dart';

class SignupScren extends StatefulWidget {
  const SignupScren({super.key});

  @override
  State<SignupScren> createState() => _SignupScrenState();
}

class _SignupScrenState extends State<SignupScren> {
  bool? ischeck = false;
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
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
                "Join The App",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
              child: Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width,
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
                  child: Column(children: [
                    CustomTextfield(
                      title: 'Name',
                      hiteTitle: 'Enter your name',
                      controller: controller.nameController,
                      isPass: false,
                    ),
                    CustomTextfield(
                      title: 'Email',
                      hiteTitle: 'Enter your email',
                      controller: controller.emailController,
                      isPass: false,
                    ),
                    CustomTextfield(
                      title: 'Password',
                      hiteTitle: 'Enter your password',
                      controller: controller.passwordController,
                      isPass: true,
                    ),
                    CustomTextfield(
                      title: 'Confirm Password',
                      hiteTitle: 'Re-enter your password',
                      controller: controller.confirmPasswordController,
                      isPass: true,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.red,
                            value: ischeck,
                            onChanged: (newValue) {
                              setState(() {
                                ischeck = newValue;
                              });
                            }),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'I agree to the terms and privacy policy',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            color: ischeck == true ? Colors.red : Colors.grey,
                            title: 'Sign Up',
                            textColor: Colors.white,
                            onPressed: () async {
                              if (ischeck == true) {
                                await controller.signupPatientMethod();
                              } else {
                                Get.snackbar("Error", "Please accept terms");
                              }
                            },
                          ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
