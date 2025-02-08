import 'package:doctorappoiment/Screen/DoctorHome/PatientsScreen.dart';
import 'package:doctorappoiment/Screen/DoctorHome/appoinmentList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/DoctorController .dart';


class DoctorDashboardScreen extends StatelessWidget {
  final DoctorController controller = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Doctor Dashboard"),
        backgroundColor: Colors.blue.shade900,
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Manage Appointments',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900),
            ),
            SizedBox(height: 20),
            Obx(() {
              return _buildCalendar();
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showCreateAppointmentDialog(context);
              },
              child: Text("Create Appointment"),
              style: ElevatedButton.styleFrom(primary: Colors.blue.shade900),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue.shade900),
            child: Text(
              "Doctor Panel",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.list,
            text: "My Appointments",
            onTap: () {
              Get.to(() => AppointmentListScreen());
            },
          ),
          _buildDrawerItem(
            icon: Icons.people,
            text: "Patients",
            onTap: () {
              controller.fetchPatientsForDoctor();
              Get.to(() => PatientsScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade900),
      title: Text(text, style: TextStyle(color: Colors.blue.shade900)),
      onTap: onTap,
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2022, 01, 01),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: controller.selectedDay.value,
      calendarFormat: CalendarFormat.month,
      onDaySelected: (selectedDay, focusedDay) {
        controller.selectedDay.value = selectedDay;
        controller.selectedTime.value = '';  // Reset time when a new day is selected
      },
      selectedDayPredicate: (day) {
        return isSameDay(controller.selectedDay.value, day);
      },
    );
  }

  void _showCreateAppointmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create New Appointment"),
          content: SingleChildScrollView( // Wrap with SingleChildScrollView
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTimePicker(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add a check to ensure the selected time is valid before creating the appointment
                    if (controller.selectedTime.value.isNotEmpty) {
                      controller.createAppointment(
                        controller.selectedDay.value,
                        controller.selectedTime.value,
                      );
                      Get.back();
                    } else {
                      // Show a message if no time is selected
                      Get.snackbar("Error", "Please select a time for the appointment.");
                    }
                  },
                  child: Text("Create Appointment"),
                  style: ElevatedButton.styleFrom(primary: Colors.blue.shade900),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Select Time:", style: TextStyle(color: Colors.blue.shade900)),
        SizedBox(width: 20),
        Obx(() {
          // Ensure there are available times before rendering the dropdown
          if (controller.availableTimes.isEmpty) {
            return Text("No available times");
          }
          return DropdownButton<String>(
            value: controller.selectedTime.value.isEmpty ? null : controller.selectedTime.value,
            items: controller.availableTimes.map((String time) {
              return DropdownMenuItem<String>(value: time, child: Text(time));
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                controller.selectedTime.value = newValue;
              }
            },
            hint: Text("Select a time"),
          );
        })
      ],
    );
  }
}
