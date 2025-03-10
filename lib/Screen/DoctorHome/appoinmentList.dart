import 'package:doctorappoiment/Style/colors.dart';
import 'package:doctorappoiment/controller/DoctorController%20.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppointmentListScreen extends StatelessWidget {
  final DoctorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text("My Appointments"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final bookedAppointments =
            controller.appointments.where((e) => e.patientId != null).toList();
        final availableAppointments =
            controller.appointments.where((e) => e.patientId == null).toList();

        if (controller.appointments.isEmpty) {
          return Center(child: Text("No appointments found"));
        }

        return ListView(
          padding: EdgeInsets.all(16),
          children: [
            if (bookedAppointments.isNotEmpty) ...[
              Text(
                "Booked Appointments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(height: 10),
              _buildAppointmentList(bookedAppointments, "Booked"),
              SizedBox(height: 20),
            ],
            if (availableAppointments.isNotEmpty) ...[
              Text(
                "Available Appointments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 10),
              _buildAppointmentList(availableAppointments, "Available"),
            ],
          ],
        );
      }),
    );
  }

  Widget _buildAppointmentList(List appointments, String status) {
    return Column(
      children: appointments.map((appointment) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text("Date: ${appointment.appointmentDate}"),
            subtitle: Text("Time: ${appointment.appointmentTime}"),
            trailing: Text(
              status,
              style: TextStyle(
                color: status == "Available" ? Colors.green : Colors.red,
              ),
            ),
            onTap: status == "Booked"
                ? () {
                    Get.defaultDialog(
                      title: "Cancel Appointment",
                      middleText: "Are you sure you want to cancel this appointment?",
                      textCancel: "No",
                      textConfirm: "Yes",
                      confirmTextColor: Colors.white,
                      onConfirm: () async {
                        try {
                          Get.back(); // إغلاق الحوار قبل العملية
                          controller.isLoading.value = true;
                          await controller.cancelAppointment(appointment.id);
                          await controller.fetchDoctorAppointments();
                          Get.snackbar("Success", "Appointment canceled successfully",
                              backgroundColor: Colors.green.shade300);
                        } catch (e) {
                          Get.snackbar("Error", "Failed to cancel the appointment",
                              backgroundColor: Colors.red.shade300);
                        } finally {
                          controller.isLoading.value = false;
                        }
                      },
                    );
                  }
                : null,
          ),
        );
      }).toList(),
    );
  }
}
