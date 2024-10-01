class Credential {
  final String id;
  final String email;
  final String apiKey;
  final String deviceName;
  final String deviceModel;
  final DateTime registeredAt;

  Credential({
    required this.id,
    required this.email,
    required this.apiKey,
    required this.deviceName,
    required this.deviceModel,
    required this.registeredAt,
  });

  factory Credential.fromJson(Map<String, dynamic> json) {
    return Credential(
      id: json['_id'],
      email: json['email'],
      apiKey: json['apiKey'],
      deviceName: json['deviceName'],
      deviceModel: json['deviceModel'],
      registeredAt: DateTime.parse(json['registeredAt']),
    );
  }
}
