class Doctor {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String specialization;
  final String licenseNumber;
  final String? certificatePath;
  final bool isVerified;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.specialization,
    required this.licenseNumber,
    this.certificatePath,
    required this.isVerified,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? 'No email',
      emailVerifiedAt: json['email_verified_at'],
      specialization: json['specialization'] ?? 'Not specified',
      licenseNumber: json['license_number'] ?? 'Unknown',
      certificatePath: json['certificate_path'],
      isVerified: (json['is_verified'] ?? 0) == 1,
    );
  }
}
