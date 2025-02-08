import 'dart:io';

class Doctor {
  final int id;
  final String name;
  final String specialization;
  final File? certificateUrl;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    this.certificateUrl,
  });

  // Factory لتحويل JSON إلى كائن Doctor
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as int,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      certificateUrl: json['certificate_url'] as File?,
    );
  }
}
