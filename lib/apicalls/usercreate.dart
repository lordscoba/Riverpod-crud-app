import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testriverpod/apicalls/constants.dart';
import 'package:testriverpod/models/users.dart';

final postRequestProvider =
    StateNotifierProvider<PostRequestNotifier, UserState>((ref) {
  return PostRequestNotifier();
});

class PostRequestNotifier extends StateNotifier<UserState> {
  PostRequestNotifier() : super(const UserState());

  Future<void> performPostRequest(ref) async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true);
      final dio = Dio();
      // Make the POST request
      final response =
          await dio.post(EnvironmentConfig.createUsersListUrl, data: ref);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Request successful
        state = state.copyWith(
            isLoading: false,
            data: response.data as Map<String, dynamic>,
            error: '');
        // debugPrint(response.data.toString());
      }
      // debugPrint(response.statusMessage.toString());
    } on DioError catch (e) {
      if (e.response != null) {
        // debugPrint(e.response?.data['message'].toString());
        state = state.copyWith(
            isLoading: false, error: e.response?.data['message']);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message.toString());
        state = state.copyWith(isLoading: false, error: e.message.toString());
      }
      // Request error
    }
  }
}
