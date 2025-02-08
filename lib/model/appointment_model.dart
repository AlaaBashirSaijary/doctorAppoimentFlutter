class Appointment {
  final int id;
  final int doctorId;
  final int? patientId;
  final String appointmentDate;
  final String appointmentTime;
  final bool isAvailable;

  Appointment({
    required this.id,
    required this.doctorId,
    this.patientId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.isAvailable,
  });

  // تحويل JSON إلى كائن Appointment
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      doctorId: json['doctor_id'],
      patientId: json['patient_id'],
      appointmentDate: json['appointment_date'],
      appointmentTime: json['appointment_time'],
      isAvailable: json['is_available'],
    );
  }

  // تحويل كائن Appointment إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'patient_id': patientId,
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
      'is_available': isAvailable,
    };
  }
}
