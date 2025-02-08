import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/doctor_model.dart';

class AdminController extends GetxController {
  var isLoading = true.obs;
  var doctors = <Doctor>[].obs;
  final String baseUrl = 'https://api-doctor.clingroup.net/api';
  String? userToken;

  @override
  void onInit() {
    loadToken();
    super.onInit();
  }

  // Load token from SharedPreferences
  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('token');
    if (userToken != null) {
      fetchPendingDoctors();
    } else {
      Get.snackbar('Error', 'User token not found');
    }
  }

  // Helper function to build headers with authorization
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

  // Fetch list of pending doctors
  Future<void> fetchPendingDoctors() async {
    isLoading(true);
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/admin/pending-doctors'),
        headers: headers,
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var doctorList = jsonData['doctors'] as List;

        doctors.value = doctorList.map((e) => Doctor.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load doctors');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Fetch certificate image URL for a specific doctor
  Future<String?> fetchDoctorCertificate(int doctorId) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/admin/doctor/$doctorId/certificate'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('$data');
        return data['doctor']['certificate_url'];
      } else {
        Get.snackbar('Error', 'Certificate not found');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return null;
  }

  // Verify doctor's account
  Future<void> verifyDoctor(int doctorId) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/admin/verify-doctor/$doctorId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Doctor verified successfully');
        fetchPendingDoctors();
      } else {
        Get.snackbar('Error', 'Failed to verify doctor');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Reject doctor's account
  Future<void> rejectDoctor(int doctorId) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/admin/reject-doctor/$doctorId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Doctor rejected successfully');
        fetchPendingDoctors();
      } else {
        Get.snackbar('Error', 'Failed to reject doctor');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
