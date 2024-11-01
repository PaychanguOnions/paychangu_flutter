class PaymentVerificationResponse {
  final String status;
  final String message;
  final VerificationData data;

  PaymentVerificationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PaymentVerificationResponse.fromJson(Map<String, dynamic> json) {
    return PaymentVerificationResponse(
      status: json['status'],
      message: json['message'],
      data: VerificationData.fromJson(json['data']),
    );
  }
}

class VerificationData {
  final String eventType;
  final String txRef;
  final String mode;
  final String type;
  final String status;
  final int numberOfAttempts;
  final String reference;
  final String currency;
  final int amount;
  final int charges;
  final CustomizationData? customization;
  final Map<String, dynamic>? meta;
  final AuthorizationData authorization;
  final CustomerData customer;
  final List<LogEntry> logs;
  final String createdAt;
  final String updatedAt;

  VerificationData({
    required this.eventType,
    required this.txRef,
    required this.mode,
    required this.type,
    required this.status,
    required this.numberOfAttempts,
    required this.reference,
    required this.currency,
    required this.amount,
    required this.charges,
    this.customization,
    this.meta,
    required this.authorization,
    required this.customer,
    required this.logs,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VerificationData.fromJson(Map<String, dynamic> json) {
    return VerificationData(
      eventType: json['event_type'],
      txRef: json['tx_ref'],
      mode: json['mode'],
      type: json['type'],
      status: json['status'],
      numberOfAttempts: json['number_of_attempts'],
      reference: json['reference'],
      currency: json['currency'],
      amount: json['amount'],
      charges: json['charges'],
      customization: json['customization'] != null 
          ? CustomizationData.fromJson(json['customization']) 
          : null,
      meta: json['meta'],
      authorization: AuthorizationData.fromJson(json['authorization']),
      customer: CustomerData.fromJson(json['customer']),
      logs: (json['logs'] as List)
          .map((log) => LogEntry.fromJson(log))
          .toList(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class CustomizationData {
  final String? title;
  final String? description;
  final String? logo;

  CustomizationData({
    this.title,
    this.description,
    this.logo,
  });

  factory CustomizationData.fromJson(Map<String, dynamic> json) {
    return CustomizationData(
      title: json['title'],
      description: json['description'],
      logo: json['logo'],
    );
  }
}

class AuthorizationData {
  final String channel;
  final String? cardNumber;
  final String? expiry;
  final String? brand;
  final String? provider;
  final String? mobileNumber;
  final String? completedAt;

  AuthorizationData({
    required this.channel,
    this.cardNumber,
    this.expiry,
    this.brand,
    this.provider,
    this.mobileNumber,
    this.completedAt,
  });

  factory AuthorizationData.fromJson(Map<String, dynamic> json) {
    return AuthorizationData(
      channel: json['channel'],
      cardNumber: json['card_number'],
      expiry: json['expiry'],
      brand: json['brand'],
      provider: json['provider'],
      mobileNumber: json['mobile_number'],
      completedAt: json['completed_at'],
    );
  }
}

class CustomerData {
  final String? email;
  final String firstName;
  final String lastName;

  CustomerData({
    this.email,
    required this.firstName,
    required this.lastName,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}

class LogEntry {
  final String type;
  final String message;
  final String createdAt;

  LogEntry({
    required this.type,
    required this.message,
    required this.createdAt,
  });

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      type: json['type'],
      message: json['message'],
      createdAt: json['created_at'],
    );
  }
} 