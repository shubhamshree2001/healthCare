class ChangePasswordRequest {
  String token;
  String current;
  String update;
  ChangePasswordRequest(
      {required this.token, required this.current, required this.update});
}
