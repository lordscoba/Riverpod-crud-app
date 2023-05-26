import 'package:freezed_annotation/freezed_annotation.dart';

part 'users.freezed.dart';
part 'users.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    @Default('') String name,
    @Default('') String username,
    @Default('') String password,
    @Default('') String email,
    // Add other necessary fields
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    @Default({}) Map<String, dynamic> data,
    @Default(false) bool isLoading,
    @Default('') String error,
  }) = _UserState;

  const UserState._();
}
