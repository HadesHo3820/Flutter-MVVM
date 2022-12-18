class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;
  LoginRequest({
    required this.email,
    required this.password,
    required this.imei,
    required this.deviceType,
  });
}

class RegisterRequest {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;
  RegisterRequest(
      {required this.countryMobileCode,
      required this.userName,
      required this.email,
      required this.password,
      required this.mobileNumber,
      required this.profilePicture});
}
