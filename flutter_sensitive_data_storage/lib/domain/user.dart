import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    @Default('') String firstName,
    @Default('') String lastName,
    @Default(0) int age,
    @Default('') String avatar,
    @Default('') String phoneNumber,
  }) = _User;

  const User._();

  String get fullName => [firstName, lastName].join(' ');
}