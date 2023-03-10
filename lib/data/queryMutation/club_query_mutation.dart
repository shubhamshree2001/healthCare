import '../localStorage/local_storage.dart';

class ClubQueryMutation {

  static String getCommunityConfig() {
    return '''  query {
        auth(token: "${LocalStorage.getAccessToken()}")
        {
          getCommunityConfig {
            postVentPlaceholder
            replyVentPlaceholder
            giftSuccessMessage
            sendGiftMessage
            clubListCtaIcon
            anonymous_profile
            is_paid
            reactions {
              colored_url
              uncolored_url
              type
            }
            feedback {
              id
              kind
              question
              options
            }
            followAsset
            disable_config {
              vents {
                disable
                text
                image
              }
            }
            locked_content_image {
              vent
              vent_reply
            }
            plan_page_title
            disable_config {
              vents {
                disable
                text
                image
              }
            }
            locked_content_image {
              vent
              vent_reply
            }
            subscription_benefits {
              type
              asset
            }
            feature_info_screen {
              type
              asset
            }      
          }
        }
      }
''';
  }

  static String getCommunityList() {

    return '''  query listCommunities(\$token: String!, \$screen: EnumCommunityScreen, \$inclusive: [String], \$exclusive: [String], \$limit: Int, \$offset: Int) {
                  auth(token: \$token) {
                    listCommunities(screen: \$screen, inclusive: \$inclusive, exclusive: \$exclusive,  limit: \$limit, offset: \$offset) {
                      id
                      slug
                      name
                      image {
                        banner
                        icon
                      }
                      has_new_content {
                        type
                        color
                      }
                      description
                      follower{
                        follower_count
                        follower_text
                        follower_images
                      }
                      follow
                      share{
                        title
                        text
                        image
                        url
                      }
                    }
                  }
                }
''';
  }

  static String listVents(String filter,String community,{int limit=25,int offset=0}) {

    return '''  query {
        auth(token: "${LocalStorage.getAccessToken()}") {
          listVents(filter:$filter, community:"$community", limit:$limit, offset:$offset){
             vents{
                          id
                          user_name
                          message
                          verified
                          user_title
                          avatar
                          vent_time
                          likes_count
                          replies_count
                          is_liked
                          is_sensitive
                          is_gifting_enabled
                          share {
                            url
                            text
                          }
                          type
                          background_image
                          text
                          image
                          is_anonymous
                          resources
                          resource_objects{
                            name
                            date
                            url
                            locked
                            uploaded_by
                          }
                          cta{
                            text
                            wait
                            deeplink{
                              screen
                              paramOne
                              paramTwo
                            }
                          }
                          pinned
                          locked
                        }
            last_fetched_time
          }  
      }
      }
''';
  }

  static String updateFollowStatus(String communityId,bool isFollow) {

    return '''  mutation {
        authMutation(token: "${LocalStorage.getAccessToken()}") {
          update{
            communityFollow(community:"$communityId",follow:$isFollow)
          }
        } 
      }
''';
  }

  static String updateVent(String venId,{bool? isMarked,bool? isAnonymous,bool? isSensitive,bool? isDeactivate}) {
    var reactionString = '';
    if(isMarked!=null)
      {
         reactionString = 'reaction:{type: HEART, marked: $isMarked }';
      }
    var isAnonymousString = '';
    if(isAnonymous!=null)
    {
      isAnonymousString = 'is_anonymous:$isAnonymous';
    }
    var isSensitiveString = '';
    if(isSensitive!=null)
    {
      isSensitiveString = 'is_sensitive:$isSensitive';
    }
    var isDeactivateString = '';
    if(isDeactivate!=null)
    {
      isDeactivateString = 'deactivate:$isDeactivate';
    }

    return '''  mutation {
        authMutation(token: "${LocalStorage.getAccessToken()}") {
          update{
            updateVent(vent:"$venId",$reactionString $isAnonymousString $isSensitiveString $isDeactivateString)
          }
        }
      }
''';
  }

  static String updateVent2(String venId,bool isMarked) {

    return '''  mutation {
        authMutation(token: "${LocalStorage.getAccessToken()}") {
          update{
            updateVent(vent:"$venId",reaction:{type: HEART, marked: $isMarked} )
          }
        }
      }
''';
  }

  static String getCommunityInfo(String communitySlug) {

    return ''' query {
    auth(token:"${LocalStorage.getAccessToken()}"){
    getCommunityInfo(community:"$communitySlug"){
      id
      name
      description
      moderators{
        name
        photo
        verified
        title
      }
      locked
      resources{
        name
        date
        url
        locked
        uploaded_by
      }
      follower{
        follower_images
        follower_count
        follower_text
      }
    }
  }
}
''';
  }


  static String getVentRepliesList(String ventId,{int limit = 25,int offset=0}) {

    return ''' query {
        auth(token: "${LocalStorage.getAccessToken()}") {
          listVentReplies(parent:"$ventId", limit:$limit, offset:$offset){
            last_fetched_time
            replies{
              id
              message
              user_name
              avatar
              vent_time
              locked
              verified
              user_title
            }
          }  
        }
      }
''';
  }


  static String checkVentStatus(String ventId,String lastFetchedTime) {

    return ''' query {
         auth(token:"${LocalStorage.getAccessToken()}"){
    checkVentStatus(parent:"$ventId",lastFetchedTime:"$lastFetchedTime")
  }
      }
''';
  }
  static String getVent(String ventId) {
    return ''' query {
        auth(token: "${LocalStorage.getAccessToken()}") {
          getVent(vent:"$ventId"){
            id
            message
            user_name
            avatar
            likes_count
            vent_time
            is_liked
            is_gifting_enabled
            is_sensitive
            is_anonymous
            resource_objects{
            name
            date
            url
            locked
            uploaded_by
           }
            is_my_vent
            share{
              text
              url
            }
            community{
              name
            }     
          }  
        }
      }
''';
  }

  static String postVent(String message,bool isAnonymous,bool isSensitive,String parent) {
    return ''' mutation {
        authMutation(token: "${LocalStorage.getAccessToken()}") {
          create{
            postVent(message:"$message", is_anonymous: $isAnonymous  community:"$parent"  is_sensitive:$isSensitive)
          }
        }
      }
''';
  }

  static String replyVent(String message,bool isAnonymous,String parent) {
    return ''' mutation {
        authMutation(token: "${LocalStorage.getAccessToken()}") {
          create{
            postVent(message:"$message", is_anonymous: $isAnonymous  parent:"$parent")
          }
        }
      }
''';
  }

  static String listCommunityEvents(String communityId,{int limit=25,int offset=0}) {
    return ''' query{
                    auth(token: "${LocalStorage.getAccessToken()}") {
                      listCommunityEvents(limit: $limit, offset: $offset) {
                          id
                          kind
                          slug
                          name
                          image
                          locked
                          start
                          type
                          background_image
                          text
                          end
                          is_booked
                          is_live
                          enrolled{
                            enrolled_count
                            color
                            enrolled_text
                            enrolled_user_photo
                          }
                          community{
                            name
                          }
                          cta{
                            text
                            deeplink{
                              screen
                              paramOne
                              paramTwo
                            }
                          }
                      }
                    }
                  }
''';
  }

  static String getBoatAvailability(String eventId) {
    return ''' query{
        auth(token : "${LocalStorage.getAccessToken()}"){
          getBoatAvailability(
            boat : "$eventId"
          )
        }
      }
''';
  }


  static String getBoat(String slug) {
    return ''' query{
        auth(token : "${LocalStorage.getAccessToken()}"){
            getBoat(
                boat : "$slug"
              ){
                id
                title
                image
                description
                type
                booked
                locked
                enrolled {
                  enrolled_count
                  enrolled_user_photo
                  enrolled_text
                  color
                }
                cta {
                  text
                  wait
                  deeplink {
                    screen
                    paramOne
                    paramTwo
                  }
                }
                facilitator {
                  name
                  photo
                  title
                  redirect
                  verified
                }
                share {
                  title
                  text
                  image
                  url
                }
                cards{
                  title
                  data
                }
                mode
                video
                price
                slots
                slug
                meeting
                booked
                start_at
                end_at
                categories
                status
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

  static String notifyEvent(String eventId) {
    return ''' mutation{
      authMutation(token: "${LocalStorage.getAccessToken()}") {
        create {
          eventNotify(id:"$eventId") 
        }
      }
    }
''';
  }

  static String subscribe(String planId,String type) {
    return ''' mutation {
        authMutation(token: "${LocalStorage.getAccessToken()}") {
          create{
            subscribe(type: $type, plan:{plan_id : "$planId"}){
              gateway
              id
            }
          }
        }
     }
''';
  }

  static String submitFeedback(String id,String type,String answer) {
    return ''' mutation
     submitFeedbackV2(\$answers: [FeedbackAnswerInput!]!){
        authMutation(token : "${LocalStorage.getAccessToken()}"){
          create{
            submitFeedbackV2(
              kind :$type
              id : "$id"
              answers : \$answers
              )
        }
        }
      }
''';
  }


  static String createOrder(String ventId) {
    return ''' mutation 
      false{
        authMutation(token : "${LocalStorage.getAccessToken()}"){
          create{
            createOrder(
              
              type :VENT_GIFT
              ventGift : {
                  vent: "$ventId",                 
                }
            )
          }
        }
      }
''';
  }
}
