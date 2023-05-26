// gets users from map api
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testriverpod/apicalls/constants.dart';

Future<void> deleteData(String id) async {
  final dio = Dio();
  try {
    final response =
        await dio.delete(EnvironmentConfig.deleteUsersListUrl + id);
    // Handle the response or any further processing
    if (response.statusCode == 200) {
      return response.data;
    }
  } on DioError catch (e) {
    // debugPrint(e.toString());
    if (e.response != null) {
      debugPrint(e.response?.data['message'].toString());
      // debugPrint(e.response?.data.toString());
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      debugPrint(e.requestOptions.toString());
      debugPrint(e.message.toString());
    }
  }
}
