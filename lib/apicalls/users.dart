import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testriverpod/apicalls/constants.dart';
import 'package:testriverpod/models/users.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

// gets users from array Api
final usersListProvider = FutureProvider<List<UserModel>>((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get(EnvironmentConfig.getUsersListUrl);

  final data = response.data as List<dynamic>;
  // debugPrint(data.toString());

  final users = data.map((json) => UserModel.fromJson(json)).toList();
  // debugPrint(users.toString());
  return users;
});

// gets users from map api
final usersProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.get(EnvironmentConfig.getUsersUrl);

  if (response.statusCode == 200) {
    return response.data as Map<String, dynamic>;
  } else {
    throw Exception('Failed to fetch map data');
  }
  // return data;
});
