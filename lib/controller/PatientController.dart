import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/appointment_model.dart';

class PatientController extends GetxController {
  var isLoading = false.obs;
  var appointments = <Appointment>[].obs;
  String? userToken;

  final String baseUrl = "https://api-doctor.clingroup.net/api";

  @override
  void onInit() {
    loadToken();
    super.onInit();
  }

  // تحميل التوكن من SharedPreferences
  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('token');
    if (userToken != null) {
      fetchPatientAppointments();
    } else {
      Get.snackbar('Error', 'User token not found');
    }
  }

  // الهيدر باستخدام الـ token المحمّل
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

  // جلب جميع مواعيد المريض
  Future<void> fetchPatientAppointments() async {
    isLoading(true);
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/patient/appointments'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var appointmentsList = jsonData['appointments'] as List;
        appointments.value =
            appointmentsList.map((e) => Appointment.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load appointments');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // إلغاء موعد
  Future<void> cancelAppointment(int appointmentId) async {
    try {
      var response = await http.delete(
        Uri.parse('$baseUrl/patient/appointments/$appointmentId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Appointment canceled successfully');
        appointments.removeWhere((appointment) => appointment.id == appointmentId);
      } else {
        Get.snackbar('Error', 'Failed to cancel appointment');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // حجز موعد جديد
  Future<void> bookAppointment(int appointmentId) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/patient/book-appointment/$appointmentId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Appointment booked successfully');
        await fetchPatientAppointments(); // تحديث البيانات بعد الحجز
      } else {
        Get.snackbar('Error', 'Failed to book appointment');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
