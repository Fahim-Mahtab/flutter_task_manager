import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    ///Created static so that we dont need to create instance of class and we can call it directly
    try {
      Uri uri = Uri.parse(url);
      _logReq(url);
      Response response = await get(uri);
      _logRes(url, response);
      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          body: decodedData,

          ///Passed decoded data to body property of NetworkResponse
          ///class object and returned it to caller function
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: decodedData["data"],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        responseCode: -1,

        /// response code -1 means error and the type of the error is string
        errorMessage: e.toString(),

        ///error msg converted to string and passed to NetworkResponse class object
      );
    }
  }

  static Future<NetworkResponse> postRequest(
    ///Created static so that we dont need to create instance of class and we can call it directly
    String url, {
    Map<String, dynamic>?
    body, //optional named parameter body and its type is Map<String, dynamic> and nullable because
    // we dont need to pass it to the caller function if we dont want to pass it
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logReq(url, body: body);
      Response response = await post(
        uri,
        headers: {
          "Content-Type": "application/json",
        }, //header for post request to send json data to api
        body: jsonEncode(
          body,
        ), // JsonEncode() is used to convert the body to json format and
        // send it to api because api only accepts json data for post request
      );
      _logRes(
        url,
        response,
      ); // Log the response body and status code to the console for debugging purposes.
      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Check if the response status code is 200 (OK).
        // If it is, return a NetworkResponse object with isSuccess set to true,
        // responseCode set to the status code of the response,
        // nd body set to the decoded data.

        return NetworkResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          body:
              decodedData, // Pass the decoded data to the body property of the NetworkResponse object.
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: decodedData["data"],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void _logReq(String url, {Map<String, dynamic>? body}) {
    debugPrint(
      "url $url\n"
      "body : $body",
    );
  }

  static void _logRes(String url, Response response) {
    debugPrint(
      "url $url\n"
      "Status code :${response.statusCode}\n"
      "Body : ${response.body}",
    );
  }
}

class NetworkResponse {
  // class to handle response from api and return it to caller function and handle it accordingly in caller function
  bool isSuccess;
  String errorMessage;
  final int responseCode;
  dynamic body;

  NetworkResponse({
    required this.isSuccess,
    required this.responseCode,
    this.errorMessage = "something went wrong",
    this.body,
  });
}
