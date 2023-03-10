import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';

class GuidesQueryMutation {
  static String getListModules({String searchText = ""}) {
    return ''' query getListModules {
  auth(token: "d9ba07ab5a8b90ce171ea4543761c2d0249c759ca990e282248e5e7d568a78953f0a710e3d14656de6a6dd8db65487b20de57d17fc7894c8c2f3fe43a8758ff75eeb004d8b2a073f000381411b36151fd74d6f3f94e0186c10a9a0b2fcf1ef14c1778e8e7a12554f24fab1e9dbb9365ce461100afcb2e0163906ca2e3ddd468e") {
    listModules(filter: [], kind: GUIDE, search: "$searchText" ) {
      text
      image
      locked
      slug
      filters
      statistics {
        streams
        time
      }
    }
  }
}''';
  }

  static String getListModulesFilters({int limit = 10, int offset = 10}) {
    return ''' query getListModuleFilter {
  auth(token: "d9ba07ab5a8b90ce171ea4543761c2d0249c759ca990e282248e5e7d568a78953f0a710e3d14656de6a6dd8db65487b20de57d17fc7894c8c2f3fe43a8758ff75eeb004d8b2a073f000381411b36151fd74d6f3f94e0186c10a9a0b2fcf1ef14c1778e8e7a12554f24fab1e9dbb9365ce461100afcb2e0163906ca2e3ddd468e") {
    listModuleFilters(kind: GUIDE, limit: $limit, offset: $offset) {
      id
      name
      parent
      level
      description
    }
  }
}''';
  }

  static String getModulesLastSession(String slug) {
    return ''' query getModuleLastSession {
  auth(token: "d9ba07ab5a8b90ce171ea4543761c2d0249c759ca990e282248e5e7d568a78953f0a710e3d14656de6a6dd8db65487b20de57d17fc7894c8c2f3fe43a8758ff75eeb004d8b2a073f000381411b36151fd74d6f3f94e0186c10a9a0b2fcf1ef14c1778e8e7a12554f24fab1e9dbb9365ce461100afcb2e0163906ca2e3ddd468e") {
    getModuleLastSession(slug: "$slug") {
      ref
      feedback
      audio
      module {
        id
        name
        version
        topics {
          topic
          done
        }
        filters
        share {
          title
          text
          image
          url
        }
        statistics {
          streams
          time
        }
        background {
          desktop
          mobile
        }
        theme {
          background
          color
          text
        }
        bgm {
          url
          volume
        }
        heading
        contents {
          id
          type
          key
          topic {
            next
            text
            progress {
              current
              total
            }
          }
          audio {
            url
            thumbnail {
              desktop
              mobile
            }
            speaker {
              image
              name
            }
            captions
          }
          exercise {
            type
            steps {
              type
              seconds
            }
            times
          }
          heading
          sub_heading
          title
          sub_title
          image {
            desktop
            mobile
          }
          info {
            body
            heading
          }
          enums
          game
          required
          card_type
          stories {
            audio {
              url
              thumbnail {
                mobile
                desktop
              }
              speaker {
                name
                image
              }
              duration {
                seconds
              }
            }
            captions
          }
          cards {
            type
            emoticon {
              alignment
              image
            }
            block
            info
            title
            image
            locked
            heading
            body
            enums
            choices {
              ref
              value
            }
            cases {
              key
              match
              value
              icon
              heading
              body
            }
            items {
              heading
              body
              theme
              enums
            }
            options {
              key
              values
            }
            cta {
              text
              deeplink {
                paramOne
                paramTwo
                screen
              }
            }
          }
          cta {
            text
            wait
            deeplink {
              paramOne
              paramTwo
              screen
            }
          }
          on_skip {
            text
            cta {
              text
              wait
              deeplink {
                paramOne
                screen
                paramTwo
              }
            }
            animation
            deeplink {
              paramOne
              paramTwo
              screen
            }
          }
          on_complete {
            text
            cta {
              text
              wait
              deeplink {
                screen
                paramTwo
                paramOne
              }
            }
            animation
            deeplink {
              screen
              paramTwo
              paramOne
            }
          }
          submit {
            query
            variables
            path
          }
          fetch {
            path
            query
            variables
          }
        }
      }
    }
  }
}''';
  }

  static String getModules(String slug) {
    return ''' query getModules {
  auth(token: "d9ba07ab5a8b90ce171ea4543761c2d0249c759ca990e282248e5e7d568a78953f0a710e3d14656de6a6dd8db65487b20de57d17fc7894c8c2f3fe43a8758ff75eeb004d8b2a073f000381411b36151fd74d6f3f94e0186c10a9a0b2fcf1ef14c1778e8e7a12554f24fab1e9dbb9365ce461100afcb2e0163906ca2e3ddd468e") {
    getModule(slug: "$slug") {
      feedback
      audio
      ref
      module {
        id
        name
        version
        topics {
          topic
          done
        }
        filters
        share {
          text
          title
          image
          url
        }
        statistics {
          streams
          time
        }
        background {
          desktop
          mobile
        }
        theme {
          background
          color
          text
        }
        bgm {
          url
          volume
        }
        heading
        contents {
          id
          type
          key
          topic {
            text
            next
            progress {
              current
              total
            }
          }
          audio {
            url
            thumbnail {
              desktop
              mobile
            }
            speaker {
              image
              name
            }
            captions
          }
          exercise {
            type
            steps {
              type
              seconds
            }
            times
          }
          heading
          sub_heading
          title
          sub_title
          image {
            desktop
            mobile
          }
          info {
            heading
            body
          }
          enums
          game
          required
          card_type
          stories {
            audio {
              url
              thumbnail {
                mobile
                desktop
              }
              speaker {
                name
                image
              }
              duration {
                seconds
              }
            }
            captions
          }
          cards {
            type
            emoticon {
              alignment
              image
            }
            block
            info
            title
            heading
            image
            locked
            body
            enums
            choices {
              ref
              value
            }
            cases {
              match
              value
              key
              icon
              heading
              body
            }
            items {
              heading
              body
              theme
              enums
            }
            options {
              key
              values
            }
            cta {
              text
              deeplink {
                paramOne
                paramTwo
                screen
              }
            }
          }
          cta {
            text
            deeplink {
              paramOne
              paramTwo
              screen
            }
            wait
          }
          on_skip {
            text
            cta {
              text
              wait
              deeplink {
                paramTwo
                screen
                paramOne
              }
            }
            animation
            deeplink {
              paramOne
              paramTwo
              screen
            }
          }
          on_complete {
            text
            cta {
              text
              wait
              deeplink {
                paramOne
                paramTwo
                screen
              }
            }
            animation
            deeplink {
              screen
              paramTwo
              paramOne
            }
          }
          submit {
            path
            query
            variables
          }
          fetch {
            query
            variables
            path
          }
        }
      }
    }
  }
} ''';
  }

  static String sumbmitModuleStatistics() {
    return ''' mutation {
  authMutation (token: "d9ba07ab5a8b90ce171ea4543761c2d062257297b22adbf9088316c6659df6e3b1f201703303d2b70062de255bac7c9c53ad3bd2d9819b978c1b013bc2391cadf29b2e670a1664423485f3740d2bd1859d694e1c33eea8cd1f6524dd5f3402666ce77b97f97f9e747349a1cc2e8dca4a08212e63e469fff0121d693b7d874668"){
    update {
      submitModuleStatistics(content: "627213c9afd4f00d77be0f60", end: "2022-11-17T06:32:25.867Z", id: "6374ac274e5af738dae0e5e8", module: "627213c9afd4f00d77be0f5f", start: "2022-11-17T06:32:21.286Z")
    }
  }
}''';
  }

  static String submitModuleResponse() {
    return ''' mutation {
  authMutation (token: "d9ba07ab5a8b90ce171ea4543761c2d062257297b22adbf9088316c6659df6e3b1f201703303d2b70062de255bac7c9c53ad3bd2d9819b978c1b013bc2391cadf29b2e670a1664423485f3740d2bd1859d694e1c33eea8cd1f6524dd5f3402666ce77b97f97f9e747349a1cc2e8dca4a08212e63e469fff0121d693b7d874668") {
    update {
      submitModuleResponse(content: "", id: "", module: "", response: "")
    }
  }
}''';
  }

  static String submitModuleFeedback() {
    return ''' mutation {
  authMutation (token: "d9ba07ab5a8b90ce171ea4543761c2d062257297b22adbf9088316c6659df6e3b1f201703303d2b70062de255bac7c9c53ad3bd2d9819b978c1b013bc2391cadf29b2e670a1664423485f3740d2bd1859d694e1c33eea8cd1f6524dd5f3402666ce77b97f97f9e747349a1cc2e8dca4a08212e63e469fff0121d693b7d874668") {
    update {
      submitModuleFeedback(feedback: "", id: "")
    }
  }
}''';
  }
}
