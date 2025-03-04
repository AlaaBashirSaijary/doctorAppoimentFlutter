import 'package:doctorappoiment/controller/PatientController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Style/consts.dart';

class BookAppointmentScreen extends StatelessWidget {
  final PatientController patientController = Get.put(PatientController());

  BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedAppointmentId = 1; // افتراضيًا رقم الموعد المحدد

    return Scaffold(
            backgroundColor: whiteColor,

      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dropdown لاختيار موعد
            DropdownButton<int>(
              value: selectedAppointmentId,
              items: List.generate(
                5,
                (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Text('Appointment ID: ${index + 1}'),
                ),
              ),
              onChanged: (value) {
                if (value != null) {
                  selectedAppointmentId = value;
                }
              },
            ),
            const SizedBox(height: 20),
            // زر لحجز الموعد
            Obx(() => ElevatedButton(
                  onPressed: patientController.isLoading.value
                      ? null
                      : () async {
                          await patientController.bookAppointment(
                            selectedAppointmentId,
                          );
                        },
                  child: patientController.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('Book Appointment'),
                )),
          ],
        ),
      ),
    );
  }
}
