import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testriverpod/apicalls/constants.dart';
import 'package:testriverpod/models/users.dart';

final putRequestProvider =
    StateNotifierProvider<PutRequestNotifier, UserState>((ref) {
  return PutRequestNotifier();
});

class PutRequestNotifier extends StateNotifier<UserState> {
  PutRequestNotifier() : super(const UserState());

  Future<void> performPutRequest(ref, String userId) async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true);
      final dio = Dio();
      debugPrint(userId);

      final id = userId;
      // Make the PUT request
      final response =
          await dio.put(EnvironmentConfig.updateUsersListUrl + id, data: ref);
      if (response.statusCode == 200) {
        // Request successful
        state = state.copyWith(
            isLoading: false,
            data: response.data as Map<String, dynamic>,
            error: '');
        // debugPrint(response.data.toString());
      }
      debugPrint(response.statusMessage.toString());
    } on DioError catch (e) {
      // debugPrint(e.toString());
      if (e.response != null) {
        debugPrint(e.response?.data['message'].toString());
        state = state.copyWith(
            isLoading: false, error: e.response?.data['message']);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message.toString());
        state = state.copyWith(isLoading: false, error: e.message.toString());
      }
    }
  }
}
