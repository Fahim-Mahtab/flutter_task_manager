class Urls {
  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";
  static const String registrationUrl = "$_baseUrl/Registration";
  static const String loginUrl = "$_baseUrl/Login";
  static const String recoveryVerifyEmailUrl = "$_baseUrl/RecoverVerifyEmail";
  static const String recoveryVerifyOtpUrl = "$_baseUrl/RecoverVerifyOtp";
  static const String recoverResetPasswordUrl =
      "$_baseUrl/RecoverResetPassword";
  static const String createTask = "$_baseUrl/createTask";
  static const String listOfTaskByStatus = "$_baseUrl/listTaskByStatus/New";
  static const String taskCompleted = "$_baseUrl/listTaskByStatus/Completed";
  static const String taskCancelled = "$_baseUrl/listTaskByStatus/Cancelled";
  static const String taskProgress = "$_baseUrl/listTaskByStatus/Progress";
  static const String taskCount = "$_baseUrl/taskStatusCount";
  static String updateTaskStatus(String taskId, String status) =>
      "$_baseUrl/updateTaskStatus/$taskId/$status";
  static const String updateProfileUrl = '$_baseUrl/ProfileUpdate';
}
