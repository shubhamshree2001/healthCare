class SubmitFeedbackRequest {
  String answer;
  String question;
  String token;
  String id;
  SubmitFeedbackRequest(
      {required this.answer,
      required this.question,
      required this.token,
      required this.id});
}
