class UpdateProfileRequest {
  String token;
  String photo;
  String name;
  String dob;
  String gender;
  String roleDescription;
  UpdateProfileRequest(
      {required this.token,
      required this.photo,
      required this.name,
      required this.dob,
      required this.gender,
      required this.roleDescription});
}
