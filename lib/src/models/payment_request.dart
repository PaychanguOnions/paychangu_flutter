import 'enums.dart';

/// Payment request model
class PaymentRequest {
  final String txRef;
  final String firstName;
  final String? lastName;
  final String? email;
  final Currency currency;
  final int amount;
  final String callbackUrl;
  final String returnUrl;
  final Map<String, String>? customization;
  final Map<String, dynamic>? meta;

  PaymentRequest({
    required this.txRef,
    required this.firstName,
    this.lastName,
    this.email,
    required this.currency,
    required this.amount,
    required this.callbackUrl,
    required this.returnUrl,
    this.customization,
    this.meta,
  });

  Map<String, dynamic> toJson() {
    return {
      'tx_ref': txRef,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'currency': currency.toString().split('.').last,
      'amount': amount.toString(),
      'callback_url': callbackUrl,
      'return_url': returnUrl,
      if (customization != null) 'customization': customization,
      if (meta != null) 'meta': meta,
    };
  }
} 