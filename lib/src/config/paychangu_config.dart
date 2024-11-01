/// Configuration class for PayChangu
class PayChanguConfig {
  final String secretKey;
  final bool isTestMode;

  PayChanguConfig({
    required this.secretKey,
    this.isTestMode = false,
  });
} 