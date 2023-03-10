import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/request/submitMciRequest.dart';

class MciQueryMutation {
  static String getMciConfig() {
    return ''' query getMciConfig{
      auth(token: "d9ba07ab5a8b90ce171ea4543761c2d02eaef632b2df2cc33079f3ecee8509500bb01340c20850c79faccfbaed45a12c1de1d44cd7995c485613a4f81357465c1bc16621bfbafb51b5de82cb3897a57ee5a35f77c4abe988deb32fb52e212d41908137e5ae8e7cf87ec857ff4bf12943") {
    getConfig {
      mci {
        loader_assets {
          image
          text
        }
        loading_time
        intro_screen {
          image
          heading
          sub_heading
          cta {
            text
            deeplink {
              screen
              paramOne
              paramTwo
            }
          }
        }
      }
    }
  }
    }''';
  }

  static String getlistMciQuestions() {
    return ''' query listMciQuestions{
  auth(token:"d9ba07ab5a8b90ce171ea4543761c2d02eaef632b2df2cc33079f3ecee8509500bb01340c20850c79faccfbaed45a12c1de1d44cd7995c485613a4f81357465c1bc16621bfbafb51b5de82cb3897a57ee5a35f77c4abe988deb32fb52e212d41908137e5ae8e7cf87ec857ff4bf12943"){
    listMciQuestions{
      id
      questions{
        id
        type
        field_type
        heading
        question
        background{
          type
          image
        }
        options{
          id
          name
          value
          order
        }
      }
    }
  }
}''';
  }

  static String submitMci(SubmitMciRequest mciResponse) {
    return ''' mutation submitMci(\$mciTestResponses:[mciTestResponseInput]!){ 
  authMutation(token:"d9ba07ab5a8b90ce171ea4543761c2d02eaef632b2df2cc33079f3ecee8509500bb01340c20850c79faccfbaed45a12c1de1d44cd7995c485613a4f81357465c1bc16621bfbafb51b5de82cb3897a57ee5a35f77c4abe988deb32fb52e212d41908137e5ae8e7cf87ec857ff4bf12943"){
    update{
      submitMCI(
        id:"${mciResponse.id}",
        start:"${mciResponse.start}",
        end:"${mciResponse.end}", 
        mciTestResponses: \$mciTestResponses,
      )
    }
  }
}''';
  }

  static String submitMciTo(SubmitMciRequest mciResponse) {
    return ''' mutation submitMci{
  authMutation(token:"d9ba07ab5a8b90ce171ea4543761c2d02eaef632b2df2cc33079f3ecee8509500bb01340c20850c79faccfbaed45a12c0f75e6a45ae03246f7a5b18029e616057db7052cdd8d2cd1b1294b92e045aeb4f06949f5ee804fe65ff2336372b52119df25ddb5f7bf44d6eec989cec0d96ade"){
    update{
      submitMCI(
        id:"${mciResponse.id}",
        start:"${mciResponse.start}",
        end:"${mciResponse.end}",
        mciTestResponses:[
          {
          question:"",
          type:"",
          fieldType:"",
          option:{
            id:"",
            name:"",
            value:"",
            order:""
          },
          start:"",
          end:""
        }
        ]
      )
    }
  }
}''';
  }

  static String getMciResult() {
    return ''' query{
  auth(token:"d9ba07ab5a8b90ce171ea4543761c2d0322e92247658521e341896ed49874314bbbdf059cb61870ace69adce00a4ee07da3e84d73a60e84b3ecc9505b00242c39b5250ff778e31db82b09fbfaba873e06917e0f9f59a5981a21c812d82b466634a41b87267c43a8ca38204e1c313e4dc"){
    getMciResult{
      ready
      questions{
        id
        type
        field_type
        heading
        question
        background{
          type
          image
        }
        options{
          id
          name
          value
          order
        }
      }
      report{
        type
        heading
        cards{
          card_type
          heading
          image
          background
          text
          score
        }
        
      }
    }
  }
}''';
  }
}
