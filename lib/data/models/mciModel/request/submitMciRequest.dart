class SubmitMciRequest {
  String id;
  String start;
  String end;
  //List<MciTest> mciTestList;
  //List<Map<String, dynamic>> mciTestResponse;
  String mciTestResponse;

  SubmitMciRequest(
      {required this.id,
      required this.start,
      required this.end,
      //required this.mciTestList,
      required this.mciTestResponse});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start': start,
      'end': end,
      'mciTestResponses': mciTestResponse,
    };
  }
}

class MciTest {
  String? question;
  String? type;
  String? fieldType;
  String? start;
  String? end;
  //OptionRequest? option;
  Map<String, dynamic>? optionMap;
  MciTest({
    required this.question,
    required this.type,
    required this.fieldType,
    required this.start,
    required this.end,
    //required this.option,
    required this.optionMap,
  });
  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'start': start,
      'end': end,
      'type': type,
      'fieldType': fieldType,
      'option': optionMap,
    };
  }
}

class OptionRequest {
  String id;
  String name;
  String value;
  String order;

  OptionRequest({
    required this.id,
    required this.name,
    required this.order,
    required this.value,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'order': order,
    };
  }
}
