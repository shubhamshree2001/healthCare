import '../localStorage/local_storage.dart';

class ResourceQueryMutation {

  static String listResources() {
    return '''   query {
          auth(token: "${LocalStorage.getAccessToken()}") {
            listResources{
                style
                image
                mobileImage
                title
                subtitle
                redirect
            }
          }
        }
''';
  }
}
