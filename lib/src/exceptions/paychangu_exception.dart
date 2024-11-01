/// Custom exception class for PayChangu errors
class PayChanguException implements Exception {
  final String message;
  final String? details;

  PayChanguException(this.message, [this.details]);

  @override
  String toString() => 'PayChanguException: $message${details != null ? '\nDetails: $details' : ''}';
} 