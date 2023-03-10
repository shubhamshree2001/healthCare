
class CreateOrderRequest
{
  String dob ;
  List<String> schedulesList;
  String doctorId;
  String mode ;
  String type;
  String issues;
  String name;
  String email;
  String code;
  String phone;
  bool isAdult;

  CreateOrderRequest({
    required this.dob,
    required this.schedulesList,
    required this.doctorId,
    required this.mode,
    required this.type,
    required this.issues,
    required this.name,
    required this.email,
    required this.code,
    required this.phone,
    this.isAdult=false
  });
}