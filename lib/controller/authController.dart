import 'dart:convert';
import 'dart:io';
import 'package:doctorappoiment/Screen/HomeScreen/homeScreen.dart';
import 'package:doctorappoiment/Screen/splach_Screen/auth_creen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Screen/AdminScreen/adminScreen.dart';
import '../Screen/DoctorHome/DoctorHomeScreen.dart';
import '../Style/consts.dart';

class AuthController extends GetxController {
  var confirmPasswordController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var specializationController = TextEditingController();
  var licenseNumberController = TextEditingController();
  var isLoading = false.obs;
  final baseUrl = 'https://api-doctor.clingroup.net/api';

  /// تسجيل الدخول
  Future<void> loginMethod() async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        String token = data['token'];
        String role = data['user']['role'][0];

        // حفظ التوكن
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // توجيه المستخدم بناءً على الدور
        if (role == 'admin') {
          Get.offAll(() => DoctorRequestsScreen());
        } else if (role == 'doctor') {
          Get.offAll(() => DoctorHomeScreen());
        } else if (role == 'patient') {
          Get.offAll(() => HomeScrenn());
        } else {
          Get.snackbar("Error", "Invalid role");
        }
      } else {
        Get.snackbar("Error", data['message'] ?? 'Login failed');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// تسجيل حساب لمريض
 Future<void> signupPatientMethod() async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup-patient'),
        body: {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
        },
      );
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        String token = data['access_token'];

        // حفظ التوكن
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        Get.snackbar("Success", "Patient signup successful");
        Get.to(() => Loginscreen()); // توجيه إلى صفحة تسجيل الدخول
      } else {
        Get.snackbar("Error", data['message'] ?? 'Signup failed');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// تسجيل حساب لطبيب
  Future<void> signupDoctorMethod({required File? certificateFile}) async {
    isLoading.value = true;
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/signup-doctor'),
      );

      request.fields['name'] = nameController.text;
      request.fields['email'] = emailController.text;
      request.fields['password'] = passwordController.text;
      request.fields['specialization'] = specializationController.text;
      request.fields['license_number'] = licenseNumberController.text;

      if (certificateFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'certificate', // الحقل الصحيح
            certificateFile.path,
          ),
        );
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      if (response.statusCode == 201) {
        Get.snackbar("Success", data['message']);
        Get.to(() => Loginscreen());
      } else {
        Get.snackbar("Error", data['error'] ?? 'Signup failed');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  /// تسجيل الخروج
  Future<void> signoutMethod(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Logged out successfully");
      } else {
        Get.snackbar("Error", 'Logout failed');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
