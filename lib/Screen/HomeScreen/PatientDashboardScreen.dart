import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctorappoiment/controller/PatientController.dart';
import 'package:doctorappoiment/Style/colors.dart';
import 'package:doctorappoiment/controller/NotificationController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/authController.dart';
import '../splach_Screen/auth_creen/login.dart';

class PatientDashboardScreen extends StatelessWidget {
  final PatientController patientController = Get.put(PatientController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    patientController.fetchPatientAppointments();
    print('$patientController');

    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Patient Dashboard'),
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: whiteColor),
            onPressed: () => showNotificationsDialog(context),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (patientController.isLoading.value) {
          print('Alaa');
          return const Center(child: CircularProgressIndicator());
        }
        print(
            'Number of appointments: ${patientController.appointments.length}');
        if (patientController.appointments.isEmpty) {
          //print('$patientController');
          return const Center(child: Text("No Appointments Available"));
        }

        return ListView.builder(
          itemCount: patientController.appointments.length,
          itemBuilder: (context, index) {
            var appointment = patientController.appointments[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text("Date: ${appointment.appointmentDate}"),
                subtitle: Text("Time: ${appointment.appointmentTime}"),
                trailing: appointment.patientId != null
                    ? IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {
                          patientController.cancelAppointment(appointment.id);
                        },
                      )
                    : IconButton(
                        icon:
                            const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {
                          patientController.bookAppointment(appointment.id);
                        },
                      ),
              ),
            );
          },
        );
      }),
    );
  }

  void showNotificationsDialog(BuildContext context) {
    notificationController.fetchNotifications();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Notifications'),
          content: Obx(() {
            if (notificationController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (notificationController.notifications.isEmpty) {
              return const Text("No notifications available.");
            }
            return SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: notificationController.notifications.length,
                itemBuilder: (context, index) {
                  var notification =
                      notificationController.notifications[index];
                  return ListTile(
                    title: Text(notification['title'] ?? 'No Title'),
                    subtitle: Text(notification['message'] ?? 'No Details'),
                    trailing: Icon(
                      notification['is_read'] == 1
                          ? Icons.done
                          : Icons.notifications,
                      color: notification['is_read'] == 1
                          ? Colors.grey
                          : Colors.blue,
                    ),
                  );
                },
              ),
            );
          }),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
            ),
            accountName: Text(
              authController.nameController.text.isNotEmpty
                  ? authController.nameController.text
                  : "Patient Name",
              style: const TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              authController.emailController.text.isNotEmpty
                  ? authController.emailController.text
                  : "patient@example.com",
              style: const TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue.shade900),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.blue.shade900),
            title: const Text('Home', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark, color: Colors.blue.shade900),
            title: const Text('My Appointments',
                style: TextStyle(color: Colors.blue)),
            onTap: () async {
              await patientController.fetchPatientAppointments();
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue.shade900),
            title: const Text('Settings', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Get.back();
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.blue.shade900),
            title: const Text('Log Out', style: TextStyle(color: Colors.blue)),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              Get.snackbar("Success", "Logged out successfully.");
              Get.offAll(() => Loginscreen());
            },
          ),
        ],
      ),
    );
  }
}
