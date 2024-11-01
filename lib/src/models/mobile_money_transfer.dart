/// Request model for mobile money transfers
class MobileMoneyTransferRequest {
  final String reference;
  final String provider;
  final String phoneNumber;
  final String currency;
  final int amount;
  final String? callbackUrl;
  final Map<String, dynamic>? meta;

  MobileMoneyTransferRequest({
    required this.reference,
    required this.provider,
    required this.phoneNumber,
    required this.currency,
    required this.amount,
    this.callbackUrl,
    this.meta,
  });

  Map<String, dynamic> toJson() {
    return {
      'reference': reference,
      'provider': provider,
      'phone_number': phoneNumber,
      'currency': currency,
      'amount': amount.toString(),
      if (callbackUrl != null) 'callback_url': callbackUrl,
      if (meta != null) 'meta': meta,
    };
  }
}

/// Response model for mobile money transfers
class MobileMoneyTransferResponse {
  final String status;
  final String message;
  final TransferData data;

  MobileMoneyTransferResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MobileMoneyTransferResponse.fromJson(Map<String, dynamic> json) {
    return MobileMoneyTransferResponse(
      status: json['status'],
      message: json['message'],
      data: TransferData.fromJson(json['data']),
    );
  }
}

/// Transfer data model
class TransferData {
  final String reference;
  final String provider;
  final String phoneNumber;
  final String currency;
  final int amount;
  final String status;
  final String? callbackUrl;
  final Map<String, dynamic>? meta;
  final String createdAt;
  final String updatedAt;

  TransferData({
    required this.reference,
    required this.provider,
    required this.phoneNumber,
    required this.currency,
    required this.amount,
    required this.status,
    this.callbackUrl,
    this.meta,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransferData.fromJson(Map<String, dynamic> json) {
    return TransferData(
      reference: json['reference'],
      provider: json['provider'],
      phoneNumber: json['phone_number'],
      currency: json['currency'],
      amount: int.parse(json['amount'].toString()),
      status: json['status'],
      callbackUrl: json['callback_url'],
      meta: json['meta'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
} 