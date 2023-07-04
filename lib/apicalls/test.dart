// gets users from map api

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testriverpod/apicalls/constants.dart';
import 'package:testriverpod/apicalls/userdetails.dart';

final usersProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final dio = ref.watch(dioProvider);
  try {
    // Add your interceptor
    dio.interceptors.add(HeadersInterceptor());

    final response = await dio.get(
      EnvironmentConfig.adminGetUrl,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch map data1');
    }
  } catch (e) {
    debugPrint(e.toString());
    throw Exception('Failed to fetch map data $e');

    // return e.toString();
  }

  // return response.data;
});

class HeadersInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add or modify headers before sending the request
    options.headers.addAll({
      // "Access-Control-Allow-Headers": "bearer",
      "bearer":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImUyc2NvYmFAZ21haWwuY29tIiwidXNlcm5hbWUiOiJlMnNjb2JhIiwidWlkIjoiNjRhMmJiZDM1NTcxMGYwZTE4OTk1MzcxIiwidHlwZSI6InVzZXIiLCJleHAiOjE2ODg1MzkxMjB9.uO-Z0S7221xNf27VJeeDxOqjiQBFCFYNn4whv1wa6rU",
    });

    super.onRequest(options, handler);
  }
}






    // dio.options.method = "GET";
    // dio.options.headers["Access-Control-Allow-Origin"] = "*";
    // dio.options.headers["Access-Control-Allow-Credentials"] = true;
    // // dio.options.headers["Access-Control-Allow-Headers"] =
    // //     "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    // dio.options.headers["Access-Control-Allow-Headers"] = "*";
    // dio.options.headers["Access-Control-Allow-Methods"] =
    //     "GET, HEAD, POST, OPTIONS";

    //  options: Options(
    //     headers: {
    //       // "Content-Type": 'application/json',
    //       // "Access-Control-Allow-Origin": "*",
    //       // "Access-Control-Allow-Credentials": true,
    //       // "Access-Control-Allow-Methods": "GET",
    //       // "Access-Control-Allow-Headers": "Content-Type",
    //       // "Referrer-Policy": "Referrer-Policy",
    //       // "Authorization": "bearer $token",
    //       "bearer":
    //           "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImUyc2NvYmFAZ21haWwuY29tIiwidXNlcm5hbWUiOiJlMnNjb2JhIiwidWlkIjoiNjRhMmJiZDM1NTcxMGYwZTE4OTk1MzcxIiwidHlwZSI6InVzZXIiLCJleHAiOjE2ODg1MzkxMjB9.uO-Z0S7221xNf27VJeeDxOqjiQBFCFYNn4whv1wa6rU",
    //     },
    //   ),