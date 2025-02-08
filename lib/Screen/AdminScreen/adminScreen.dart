import 'package:doctorappoiment/controller/AdminController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/authController.dart';
import '../../model/doctor_model.dart';

class DoctorRequestsScreen extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());
  final controller2 = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        backgroundColor: Colors.blue.shade900,
      ),
      drawer: _buildDrawer(context),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: controller.doctors.length,
                itemBuilder: (context, index) {
                  final doctor = controller.doctors[index];
                  return Card(
                    color: Colors.blue.shade50,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.blue.shade900),
                      title: Text(
                        doctor.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      subtitle: Text(
                        "Specialization: ${doctor.specialization}",
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Colors.blue.shade900),
                      onTap: () async {
                        String? certificateUrl =
                            await controller.fetchDoctorCertificate(doctor.id);
                        print('$certificateUrl');
                        _showDoctorDetailsDialog(
                            context, doctor, certificateUrl);
                      },
                    ),
                  );
                },
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
              "Admin Panel",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.list,
            text: "Pending Doctors",
            onTap: () => Get.to(() => DoctorRequestsScreen()),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade900),
      title: Text(text, style: TextStyle(color: Colors.blue.shade900)),
      onTap: onTap,
    );
  }

  void _showDoctorDetailsDialog(
      BuildContext context, Doctor doctor, String? certificateUrl) {
    Get.defaultDialog(
      title: "Doctor Details",
      content: Column(
        children: [
          certificateUrl != null
              ? Image.network(
                  certificateUrl,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 100,
                  ),
                )
              : Icon(Icons.error, color: Colors.red, size: 100),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await controller.verifyDoctor(doctor.id);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text("Accept"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await controller.rejectDoctor(doctor.id);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text("Reject"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
