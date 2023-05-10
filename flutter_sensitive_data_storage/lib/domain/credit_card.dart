import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_card.freezed.dart';

@freezed
class CreditCard with _$CreditCard {
  const factory CreditCard({
    required String number,
    required String holderName,
    required String expirationDate,
    required String cvv,
  }) = _CreditCard;

  const CreditCard._();
}