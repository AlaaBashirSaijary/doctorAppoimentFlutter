import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/appointment_model.dart';
import '../model/doctor_model.dart';

class DoctorController extends GetxController {
  var isLoading = true.obs;
  var appointments = <Appointment>[].obs;
  var patients = <Map<String, dynamic>>[].obs;
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
      fetchDoctorAppointments();
    } else {
      Get.snackbar('Error', 'User token not found');
    }
  }

  // Helper function to build headers with authorization
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

  // Fetch all appointments for the doctor
  Future<void> fetchDoctorAppointments() async {
    isLoading(true);
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/doctor/my-appointments'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var appointmentsList = jsonData['appointments'] as List;
        appointments.value = appointmentsList.map((e) => Appointment.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load appointments');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Fetch available appointments for a specific doctor
  Future<void> fetchAvailableAppointments(int doctorId) async {
    isLoading(true);
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/doctor/available-appointments/$doctorId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var appointmentsList = jsonData['appointments'] as List;
        appointments.value = appointmentsList.map((e) => Appointment.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load available appointments');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Get the list of patients for the current doctor
  Future<void> fetchPatientsForDoctor() async {
    isLoading(true);
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/doctor/patients'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var patientsList = jsonData['patients'] as List;
        patients.value = patientsList.map((e) => e as Map<String, dynamic>).toList();
      } else {
        Get.snackbar('Error', 'Failed to load patients');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Create a new available appointment for the doctor
  Future<void> createAvailableAppointment(String appointmentDate, String appointmentTime) async {
    isLoading(true);
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/doctor/create-appointment'),
        headers: headers,
        body: json.encode({
          'appointment_date': appointmentDate,
          'appointment_time': appointmentTime,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Appointment created successfully');
        fetchAvailableAppointments(int.parse(userToken ?? '0')); // Re-fetch available appointments
      } else {
        Get.snackbar('Error', 'Failed to create appointment');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Cancel an appointment by doctor
  Future<void> cancelAppointmentByDoctor(int appointmentId) async {
    isLoading(true);
    try {
      var response = await http.delete(
        Uri.parse('$baseUrl/doctor/appointments/$appointmentId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Appointment cancelled successfully');
        fetchDoctorAppointments(); // Re-fetch doctor appointments after cancellation
      } else {
        Get.snackbar('Error', 'Failed to cancel appointment');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
