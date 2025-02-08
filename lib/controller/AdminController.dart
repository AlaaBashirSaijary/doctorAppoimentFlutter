import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/doctor_model.dart';

class AdminController extends GetxController {
  var isLoading = true.obs;
  var doctors = <Doctor>[].obs;

  // Base URL for API requests
  final String baseUrl = 'https://api-doctor.clingroup.net/api';

  @override
  void onInit() {
    fetchPendingDoctors();
    super.onInit();
  }

  // Fetch list of pending doctors
  Future<void> fetchPendingDoctors() async {
    isLoading(true);
    try {
      var response = await http.get(Uri.parse('$baseUrl/pending-doctors'));

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
      var response = await http.get(Uri.parse('$baseUrl/doctor/$doctorId/certificate'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
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
      var response = await http.post(Uri.parse('$baseUrl/doctor/$doctorId/verify'));

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
      var response = await http.post(Uri.parse('$baseUrl/doctor/$doctorId/reject'));

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
