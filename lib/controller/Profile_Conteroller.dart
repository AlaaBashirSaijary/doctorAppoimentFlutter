import 'dart:convert';
import 'dart:io';
import 'package:doctorappoiment/Style/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var nameController = TextEditingController();
  var passController = TextEditingController();
  var profileImagePath = ''.obs;
  var profileImageLink = ''.obs;
  var isLoading = false.obs;
  var userData = {}.obs;
  final String baseUrl = "https://api-doctor.clingroup.net/api";

  /// تغيير صورة البروفايل
  Future<void> changeImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (image == null) return;
      profileImagePath.value = image.path;
    } on PlatformException catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  /// رفع صورة البروفايل (تحديث لاحق حسب API إذا لزم الأمر)
  Future<void> uploadProfileImage() async {
    var fileName = basename(profileImagePath.value);
    // تنفيذ رفع الصورة حسب تفاصيل الـ API المستقبلية
  }

  /// الحصول على بيانات المستخدم من API
  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "User token not found");
        return;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/auth/me'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        userData.value = json.decode(response.body);
        nameController.text = userData['name'] ?? "";
      } else {
        Get.snackbar("Error", "Failed to fetch user data");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// رفع بيانات ملف المستخدم (تحديث لاحق عند وجود API محددة)
  Future<void> uploadProfileFile({required String name, required String password, required RxString imgeUrl}) async {
    try {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        Get.snackbar("Error", "User token not found");
        return;
      }

      final response = await http.put(
        Uri.parse('$baseUrl/auth/update-profile'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'name': name,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Profile updated successfully");
        fetchUserProfile(); // تحديث البيانات
      } else {
        Get.snackbar("Error", "Profile update failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void isloding(bool bool) {}
}
