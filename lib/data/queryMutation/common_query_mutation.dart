import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';

class CommonQueryMutation {

  static String getTransactionExpiryStatus(String sessionId) {
    return '''   query{
      auth(token : "${LocalStorage.getAccessToken()}"){
        getTransactionExpiryStatus(
          session:"$sessionId"
        ){
          creditExpired
          daysLeft
        }
      }
    }
''';
  }
  static String cancelSession(String sessionId,String type) {
    return '''  mutation{
      authMutation(token : "${LocalStorage.getAccessToken()}"){
        update{
          cancel(id:"$sessionId",type:$type)
        }
      }
    }
''';
  }
}
