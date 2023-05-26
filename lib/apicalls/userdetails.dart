import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testriverpod/apicalls/constants.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

// gets users from map api
final userDetailsProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, userId) async {
  final dio = ref.watch(dioProvider);
  late String id = userId;

  final response = await dio.get(EnvironmentConfig.getSingleUsersListUrl + id);

  if (response.statusCode == 200) {
    // debugPrint(response.data.toString());
    return response.data as Map<String, dynamic>;
  } else {
    throw Exception('Failed to fetch map data');
  }
});
