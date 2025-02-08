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
  var selectedDay = DateTime.now().obs; // تم إضافة هذا المتغير
  var selectedTime = '09:00'.obs; // تم إضافة هذا المتغير
  var availableTimes = ['09:00', '10:00', '11:00', '12:00', '13:00'].obs; // تم إضافة هذا المتغير

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

  // Fetch patients for the doctor
  // Fetch patients for the doctor
Future<void> fetchPatientsForDoctor() async {
  isLoading(true);
  try {
    var response = await http.get(
      Uri.parse('$baseUrl/doctor/patients'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      
      // استخراج قائمة المرضى
      if (jsonData.containsKey('patients')) {
        var patientsList = jsonData['patients'] as List;
        patients.value = patientsList.map((e) => e as Map<String, dynamic>).toList();
      } else {
        patients.clear();
      }
    } else {
      Get.snackbar('Error', 'Failed to load patients');
    }
  } catch (e) {
    Get.snackbar('Error', e.toString());
  } finally {
    isLoading(false);
  }
}


  // Cancel an appointment by doctor
  Future<void> cancelAppointment(int appointmentId) async {
    isLoading(true);
    try {
      var response = await http.delete(
        Uri.parse('$baseUrl/doctor/appointments/$appointmentId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Appointment cancelled successfully');
        fetchDoctorAppointments(); // Re-fetch doctor appointments
      } else {
        Get.snackbar('Error', 'Failed to cancel appointment');
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
        fetchDoctorAppointments(); // Re-fetch available appointments
      } else {
        Get.snackbar('Error', 'Failed to create appointment');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Function to create appointment based on selected date and time
  Future<void> createAppointment(DateTime selectedDate, String selectedTime) async {
    String formattedDate = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    await createAvailableAppointment(formattedDate, selectedTime);
  }
}
