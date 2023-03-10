
class OrganizationResponse {
  OrganizationResponse({
    required this.organisation,
  });

  Organisation? organisation;

  factory OrganizationResponse.fromJson(Map<String, dynamic> json) => OrganizationResponse(
    organisation: json["getOrganisation"] == null ? null : Organisation.fromJson(json["getOrganisation"]),
  );

}
class Organisation {
  Organisation({
    required this.id,
  });

  String id;

  factory Organisation.fromJson(Map<String, dynamic> json) => Organisation(
    id: json["id"] == null ? null : json["id"],
  );
}
