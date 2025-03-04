import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var notifications = [].obs;
  String? userToken;

  final String baseUrl = "https://api-doctor.clingroup.net/api";
  
  // تحميل التوكن من SharedPreferences
  @override
  void onInit() {
    loadToken();
    super.onInit();
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('token');
    if (userToken != null) {
      fetchNotifications();
    } else {
      Get.snackbar('Error', 'User token not found');
    }
  }

  // جلب الإشعارات
  Future<void> fetchNotifications() async {
    isLoading(true);
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/notifications'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        notifications.value = jsonData['notifications'];
      } else {
        Get.snackbar('Error', 'Failed to load notifications');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // تحديث حالة الإشعار إلى مقروء
 

  // حذف إشعار
  
}
