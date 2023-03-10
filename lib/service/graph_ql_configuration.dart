import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import '../data/models/errorResponse/error_response.dart';
import '../exception/failure.dart';
import 'package:http/http.dart' as http;

class GraphQLConfiguration {
  static const baseUrl = "https://api.staging.mindpeers.co/graph-api";
  static HttpLink httpLink = HttpLink(baseUrl);
  static AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer ${LocalStorage.getAccessToken()}',
  );

  static var link = authLink.concat(httpLink);
  GraphQLConfiguration() {
    init();
  }
  init() {
    link = authLink.concat(httpLink);
  }

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(cache: GraphQLCache(store: InMemoryStore()), link: link),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
        link: httpLink, cache: GraphQLCache(store: InMemoryStore()));
  }


  Future<Either<Failure, Map<String, dynamic>>> callQuery(String query) async {
    try {
      final headers = {
        "Accept": "application/json, text/plain, */*",
        "Accept-Encoding":"gzip, deflate, br",
        "Content-Type": "application/json",
        "Accept-Language":"en-US,en;q=0.9",
        "api-version":"18",
        "app-version": "1.1.15",
        "Connection": "keep-alive",
        "Host": "api.staging.mindpeers.co",
        "Origin": "https://dashboard-v2.staging.mindpeers.co",
        "User-Agent":"Android"
      };
      var request = {
        "query": query,
      };
      var body=jsonEncode(request);
      var uri=Uri.parse(baseUrl);
      var response = await http.post(uri,
        headers: headers,
        body:body,
      );
      Map<String, dynamic> map = jsonDecode(response.body);
      if(response.statusCode==200)
      {
        if(map.containsKey("errors"))
        {
          return handleApiErrors(null, ErrorResponse.fromJson(map), baseUrl, query);
        }
        else
        {
          map=map["data"];
          logSuccessPrint(query, map);
          return Right(map);
        }
      }
      else if(response.statusCode==400)
      {
        return handleApiErrors(null, ErrorResponse.fromJson(map), baseUrl, query);
      }
      else
        {
          return Left(ServerFailure("", "Something went wrong!!"));
        }
    } catch (e) {
      print("Exception: $e");
      return Left(ServerFailure("", "Something went wrong!!"));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> callMutation(
      String query,{Map<String, dynamic>?variables}) async {
    log("variables==$variables");
    try {
      final headers = {
        "Accept": "application/json, text/plain, */*",
        "Accept-Encoding":"gzip, deflate, br",
        "Content-Type": "application/json",
        "Accept-Language":"en-US,en;q=0.9",
        "api-version":"18",
        "app-version": "1.1.15",
        "Connection": "keep-alive",
        "Host": "api.staging.mindpeers.co",
        "Origin": "https://dashboard-v2.staging.mindpeers.co",
        "User-Agent":"Android"
      };
      var request;
      if(variables!=null)
        {
          request = {
            "query": query,
            "variables":variables
          };
        }
      else
        {
          request = {
            "query": query,
          };
        }
      var body=jsonEncode(request);
      var uri=Uri.parse(baseUrl);
      var response = await http.post(uri,
        headers: headers,
        body:body,
      );

      Map<String, dynamic> map = jsonDecode(response.body);
      if(response.statusCode==200)
      {
        if(map.containsKey("errors"))
        {
          return handleApiErrors(null, ErrorResponse.fromJson(map), baseUrl, body);
        }
        else
        {
          map=map["data"];
          logSuccessPrint(body, map);
          return Right(map);
        }
      }
      else if(response.statusCode==400)
      {
        return handleApiErrors(null, ErrorResponse.fromJson(map), baseUrl, body);
      }
      else
      {
        logSuccessPrint(body, map);
        return Left(ServerFailure("", "Something went wrong!!"));
      }
    } catch (e) {
      print("Exception: $e");
      return Left(ServerFailure("", "Something went wrong!!"));
    }
  }

  void logSuccessPrint(String query, Map<String, dynamic> data) {
    var jsonStr = json.encode(data);
    print("BaseUrl: $baseUrl");
    print("Request Data: $query");
    log("Response Data: $jsonStr");
  }
}
