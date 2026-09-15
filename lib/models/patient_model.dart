/// Patient model representing the elderly user
class PatientModel {
  final String id;
  final String name;
  final String status;
  final String location;
  final String caregiverName;
  final String emergencyPhone;
  final String doctorContact;
  final String preferredLanguage;
  final String notes;

  const PatientModel({
    required this.id,
    required this.name,
    required this.status,
    required this.location,
    required this.caregiverName,
    required this.emergencyPhone,
    required this.doctorContact,
    this.preferredLanguage = 'English',
    this.notes = 'Enjoys morning walks and memory card games.',
  });

  PatientModel copyWith({
    String? id,
    String? name,
    String? status,
    String? location,
    String? caregiverName,
    String? emergencyPhone,
    String? doctorContact,
    String? preferredLanguage,
    String? notes,
  }) {
    return PatientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      location: location ?? this.location,
      caregiverName: caregiverName ?? this.caregiverName,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
      doctorContact: doctorContact ?? this.doctorContact,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      notes: notes ?? this.notes,
    );
  }
}
