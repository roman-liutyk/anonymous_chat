class UserAuthResponse {
  const UserAuthResponse({
    required this.token,
    required this.id,
  });

  final String token;
  final String id;

  factory UserAuthResponse.fromJson(Map<String, dynamic> json) {
    return UserAuthResponse(
      token: json['token'] as String,
      id: json['id'] as String,
    );
  }
}
