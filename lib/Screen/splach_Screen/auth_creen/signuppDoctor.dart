import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../../Style/consts.dart';
import '../../../controller/authController.dart';
import '../../../widget_common/Buttun_wideget.dart';
import '../../../widget_common/colum_widget.dart';

class SignupScrenDoctor extends StatefulWidget {
  const SignupScrenDoctor({Key? key}) : super(key: key);

  @override
  _SignupScrenDoctorState createState() => _SignupScrenDoctorState();
}

class _SignupScrenDoctorState extends State<SignupScrenDoctor> {
  var controller = Get.put(AuthController());
  File? certificateFile;

  Future<void> pickCertificateFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.single.path != null) {
      setState(() {
        certificateFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(() => Column(
                      children: [
                        CustomTextfield(
                            title: "Name",
                            hiteTitle: "Enter your name",
                            controller: controller.nameController,
                            isPass: false),
                        CustomTextfield(
                            title: "Email",
                            hiteTitle: "Enter your email",
                            controller: controller.emailController,
                            isPass: false),
                        CustomTextfield(
                            title: "Password",
                            hiteTitle: "Enter your password",
                            controller: controller.passwordController,
                            isPass: true),
                        CustomTextfield(
                            title: "Specialization",
                            hiteTitle: "Enter your specialization",
                            controller: controller.specializationController,
                            isPass: false),
                        CustomTextfield(
                            title: "License Number",
                            hiteTitle: "Enter your license number",
                            controller: controller.licenseNumberController,
                            isPass: false),
                        GestureDetector(
                          onTap: pickCertificateFile,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  certificateFile != null
                                      ? "Certificate Selected"
                                      : "Upload Certificate",
                                  style: TextStyle(
                                    color: certificateFile != null
                                        ? Colors.green
                                        : fontGrey,
                                  ),
                                ),
                                const Icon(Icons.file_upload_outlined)
                              ],
                            ),
                          ),
                        ),
                        controller.isLoading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : CustomButton(
                                color: redColor,
                                title: "Sign Up",
                                textColor: whiteColor,
                                onPressed: () async {
                                  if (certificateFile != null) {
                                    await controller.signupDoctorMethod(
                                        certificateFile: certificateFile);
                                  } else {
                                    Get.snackbar(
                                      'Incomplete Form',
                                      'Please upload your certificate.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                }),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
