class Urls {
  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";
  static const String registrationUrl = "$_baseUrl/Registration";
  static const String loginUrl = "$_baseUrl/Login";
  static const String recoveryVerifyEmailUrl = "$_baseUrl/RecoverVerifyEmail";
  static const String recoveryVerifyOtpUrl = "$_baseUrl/RecoverVerifyOtp";
  static const String recoverResetPasswordUrl =
      "$_baseUrl/RecoverResetPassword";

  static String recoveryVerifyEmail(String email) {
    return "$recoveryVerifyEmailUrl/$email";
  }

  static String recoveryVerifyOtp(String email, String otp) {
    return "$recoveryVerifyOtpUrl/$email/$otp";
  }
}
