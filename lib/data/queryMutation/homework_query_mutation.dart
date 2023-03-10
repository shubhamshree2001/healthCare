import '../localStorage/local_storage.dart';

class HomeWorkQueryMutation {

  static String getHomeworkSessions(String date) {
    return '''   query{
        auth(token : "${LocalStorage.getAccessToken()}"){
            getHomeworkSessions(
                date:"$date"
            ){
                date
                sessions{
                  doctor
                  session
                  schedule
                }
            }
        }
      }
''';
  }
  static String getHomework(String sessionId) {
    return '''   query{
        auth(token : "${LocalStorage.getAccessToken()}"){
            getHomework(
                session:"$sessionId"
            ){
                id
                note
                audio
                files
                user_files
                thoughts
                is_completed
            }
        }
      }
''';
  }
}
