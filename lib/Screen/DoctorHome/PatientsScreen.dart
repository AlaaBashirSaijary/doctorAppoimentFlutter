import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Style/colors.dart';
import '../../controller/DoctorController .dart';

class PatientsScreen extends StatelessWidget {
  final DoctorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text("My Patients"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.patients.isEmpty) {
          return Center(
            child: Text(
              "No patients found",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.patients.length,
          itemBuilder: (context, index) {
            final patient = controller.patients[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.blue.shade900),
                title: Text(
                  patient['patient_name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Appointment: ${patient['appointment_date']} at ${patient['appointment_time']}",
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
