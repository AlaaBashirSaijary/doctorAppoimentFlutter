import 'package:doctorappoiment/controller/AdminController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/doctor_model.dart';

class DoctorRequestsScreen extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Requests"),
        backgroundColor: Colors.redAccent,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: controller.doctors.length,
                itemBuilder: (context, index) {
                  final doctor = controller.doctors[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(doctor.name),
                      subtitle: Text("Specialization: ${doctor.specialization}"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () async {
                        await controller.fetchDoctorCertificate(doctor.id);
                        _showDoctorDetailsDialog(context, doctor);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _showDoctorDetailsDialog(BuildContext context, Doctor doctor) {
    Get.defaultDialog(
      title: "Doctor Certificate",
      content: Column(
        children: [
          Image.network(
            doctor.certificateUrl as String,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.error,
              color: Colors.red,
              size: 100,
            ),
          ),
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
