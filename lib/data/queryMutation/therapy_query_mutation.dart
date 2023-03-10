import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/request/create_gift_therapy_order_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/request/create_order_request.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';

class TherapyQueryMutation {
  static String getDoctorList(
      {int limit = 100, int offset = 0, String filter = ""}) {
    return '''  query{
                auth(token:"${LocalStorage.getAccessToken()}"){
                listDoctors(limit:$limit,offset:$offset,filter:"$filter"){
                  id user{ id name rating profile slug }
                  schedule experience 
                  specialisations { name }
                  degrees{ name}
                  pronouns
                }
              }
            }    
''';
  }

  static String getDoctorDetails(String slug) {
    return '''  query{
                auth(token:"${LocalStorage.getAccessToken()}"){
                getDoctor(slug:"$slug"){
                  id user{ id name rating profile slug }
                  pronouns
                  about
                  degrees{ name}
                  schedule experience 
                  share{text url image title}
                  specialisations { name }
        
                }
              }
            }    
''';
  }

  static String getTherapySessionList(String sessionType,
      {int limit = 100, int offset = 0}) {
    return '''  
    query{
      auth(token:"${LocalStorage.getAccessToken()}"){
        listTherapySessions(type:$sessionType limit : $limit offset : $offset) {
          session {
            doctor {
              name
              id
              profile 
            } 
            id 
            meeting
            mode
            schedule {
              start_date
              end_date
            }
          }
          feedback
          canceled
          homework
        }
      }   
    }
   
''';
  }

  static String getTherapyReviews(
      String id, String slug, int limit, int offset) {
    return '''  query{
                auth(token:"${LocalStorage.getAccessToken()}"){
                 listReviews(doctor:"$id",slug:"$slug",limit:$limit,offset:$offset)
                   }
            }    
''';
  }

  static String getPlanListByType(String accessToken, String type,
      {int limit = 100, offset = 0}) {
    return '''  query {
      auth(token: "${LocalStorage.getAccessToken()}") {                             
        listPlansByType(type:$type,limit:$limit,offset:$offset) {
          id
          units{
            session
            boat
          }
          name
          time
          code
          type
          description
          badge
          price
          standard
          discount
          is_tax_inclusive
          region {
            currency {
              code
              symbol
            }
            tax{
              rate
              kind
            }
          }
          gateway_id
          gateway_plan_type
          summary{
            base
            per_base
            main { 
              rate 
              value
            }
            premium { 
              rate
              value 
            }
            coupon { 
              rate 
              value
            }
            tax
            total { 
              sub
              coupon 
              grand
            }
          }
        }
        }
      }
''';
  }

  static String createGiftTherapyOrder(CreateGiftTherapyOrderRequest request) {
    return '''mutation 
      {
        authMutation(token : "${LocalStorage.getAccessToken()}"){
          create{
            createOrder(
              type :${request.type}
              gift : {
                  name: "${request.name}",
                  email: "${request.email}",
                  phone: {
                      code: "${request.code}",
                      mobile: "${request.mobileNo}"
                  }
                }
            )
          }
        }
      }
''';
  }

  static String getTherapyGiftOrder(String orderId) {
    return '''  query{
        auth(token : "${LocalStorage.getAccessToken()}"){
            getOrder(order:"$orderId"){
              id
              details
              timedout
              completed
            }
        }
      }
''';
  }

  static String getTherapyGiftPlanById(String planId) {
    return '''  
    query {
      auth(token: "${LocalStorage.getAccessToken()}") {
        getPlan(
          plan: "$planId"
        ){
          id
          units{
            session
            boat
          }
          name
          time
          code
          type
          description
          standard
          discount
          is_tax_inclusive
          region {
            currency {
              code
              symbol
            }
            tax {
              kind
              rate
            }
          }
          summary{
            base
            main { 
              rate 
              value
            }
            premium { 
              rate
              value 
            }
            coupon { 
              rate 
              value
            }
            tax
            total { 
              sub
              coupon 
              grand
            }
          }
        }
      }
    }
''';
  }

  static String cancelOrder(String orderId, String type) {
    return '''  mutation{
        authMutation(token : "${LocalStorage.getAccessToken()}"){
          update{
            cancelOrder(
              order : "$orderId"
              type : $type
            ) 
          }
        }
      }
''';
  }

  static String checkout(String orderId, String planId) {
    return '''  mutation 
        checkout(\$metaData:String!=""){
        authMutation(token : "${LocalStorage.getAccessToken()}"){
          update{
            checkout(
              order : "$orderId"
              plan : "$planId"
              metaData : \$metaData
           ){
            gateway
            id
            amount
            currency
          }
        }
      }      
      }
''';
  }

  static String getSchedulesList(String doctorId, {int limit = 100}) {
    return '''  query{
                auth(token:"${LocalStorage.getAccessToken()}"){
                  listSchedules(user:"$doctorId",limit:$limit) {
                    id
                    start_date
                    end_date
                    info
                  }
                }
              }
''';
  }

  static String createOrder(CreateOrderRequest request) {
    var parentString = "";
    if (request.type == TherapyPlanEnum.SESSION.name) {
      if (!request.isAdult) {
        parentString =
            'parent : { name : "${request.name}" email: "${request.email}" phone : {code : "${request.code}" mobile:"${request.phone}"}}';
      }
    }

    //var schedules=request.schedulesList;
    return '''  mutation 
      createOrder(\$schedules:[String!]!=${request.schedulesList}){
        authMutation(token : "${LocalStorage.getAccessToken()}"){
          create{
            createOrder(
              type :${request.type}
              session : {
                  dob : "${request.dob}",
                  schedules : \$schedules,
                  doctor : "${request.doctorId}",
                  mode : ${request.mode},
                  issues : """${request.issues}"""
                  $parentString 
                }
            )
          }
        }
      }    
''';
  }

  static String redeemGift(String code) {
    return '''  mutation {
        authMutation(token : "${LocalStorage.getAccessToken()}"){
          update{
            redeemGiftv2(
              code : "$code"
          ){
            expiry
            success
          }
        }
        }
      } 
''';
  }

  static String applyCoupon(String coupon) {
    return '''  mutation{
        authMutation(token : "${LocalStorage.getAccessToken()}"){
          update{
            applyCoupon(
              coupon: "$coupon"
              plan: "62c69a2b15f50a691b90cf1b"
               ) {
              base
              main { 
                rate 
                value
              }
              premium { 
                rate
                value 
              }
              coupon { 
                rate 
                value
              }
              tax
              total { 
                sub
                coupon 
                grand
              }
            }
          }
        }
      }
''';
  }

  static String getCreditHistory(int credits) {
    return '''  query {
        auth(token : "${LocalStorage.getAccessToken()}"){
            getCreditHistory(
              credits : $credits
          ){
            name
            credits
          }
        }
      }
''';
  }

  static String successPayment(String gateway, String type) {
    return '''  mutation 
      success(\$body:String!){
        authMutation(token : "${LocalStorage.getAccessToken()}"){
          update{
            success(
              gateway: $gateway
              type: $type
              body: \$body
          )
        }
        }
      }
''';
  }

  static String therapyRecommendations(String doctorId) {
    return '''   query{
      auth(token: "${LocalStorage.getAccessToken()}"){
        getTherapyRecommendations(doctor: "$doctorId") {
          title,
          description
          recommendations {
            kind
            locked
            slug
            image
            title
            metadata
          }
        }
      }
    }
''';
  }

  static String canRescheduleSession(String sessionId) {
    return '''    query{
        auth(token : "${LocalStorage.getAccessToken()}"){
          canRescheduleSession(id:"$sessionId")
        }
      }   
''';
  }

  static String getTherapySessionById(String sessionId) {
    return '''     query{
        auth(token : "${LocalStorage.getAccessToken()}"){
          getTherapySession(id:"$sessionId"){
            type
            feedback
            session {
              id
              schedule{
                start_date
                id
              }
              issues
              mode
              parent{name email phone{code mobile}}
              doctor{
                id
                name
                profile
              }
            }
          }
        }
      }   
''';
  }

  static String rescheduleSession(String sessionId, String scheduleId) {
    return '''     mutation {
        authMutation(token : "${LocalStorage.getAccessToken()}"){
          update{
            rescheduleSession(id: "$sessionId" , schedule:$scheduleId)
           }
        }
      }
''';
  }

  static String getMeetLink(String id, String type) {
    return '''      query{
        auth(token : "${LocalStorage.getAccessToken()}"){
          getMeetLink(id:"$id",type:$type){
            meeting
          }
        }
      }   
''';
  }
}
