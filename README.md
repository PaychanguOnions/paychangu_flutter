# PayChangu Flutter SDK

A Flutter SDK for integrating PayChangu payment gateway into your Flutter applications. This SDK provides a simple and secure way to accept payments through various payment methods including Airtel Money, TNM Mpamba, and card payments in Malawi.

[![pub package](https://img.shields.io/pub/v/paychangu_flutter.svg)](https://pub.dev/packages/paychangu_flutter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- 🔒 Secure payment processing
- 💳 Multiple payment method support
- 🌐 WebView-based checkout experience
- ✨ Simple integration
- 🔄 Real-time payment status updates
- ⚡ Asynchronous payment handling
- 🛠️ Customizable UI elements
- ✅ Transaction verification

## Getting Started

### Prerequisites

- Flutter SDK
- PayChangu merchant account and API credentials
- Minimum Flutter version: 1.17.0
- Dart SDK: ^3.5.4

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  paychangu_flutter: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### 1. Initialize PayChangu

```dart
import 'package:paychangu_flutter/paychangu_flutter.dart';

final config = PayChanguConfig(
  secretKey: 'your_secret_key_here',
  isTestMode: true, // Set to false in production
);

final paychangu = PayChangu(config);
```

### 2. Create a Payment Request

```dart
final request = PaymentRequest(
  txRef: 'unique_transaction_reference',
  firstName: 'John',
  lastName: 'Doe',
  email: 'john@example.com',
  currency: Currency.MWK,
  amount: 1000,
  callbackUrl: 'https://your-domain.com/callback',
  returnUrl: 'https://your-domain.com/return',
);
```

### 3. Launch Payment

```dart
Widget buildPaymentWidget() {
  return paychangu.launchPayment(
    request: request,
    onSuccess: (response) {
      print('Payment successful: $response');
      // Verify the transaction after success
      verifyTransaction(response['tx_ref']);
    },
    onError: (error) {
      print('Payment failed: $error');
    },
    onCancel: () {
      print('Payment cancelled');
    },
  );
}
```

### 4. Verify Transaction

Always verify transactions server-side before providing value to your customer:

```dart
Future<void> verifyTransaction(String txRef) async {
  try {
    // Verify the transaction
    final verification = await paychangu.verifyTransaction(txRef);
    
    // Validate the payment details
    final isValid = paychangu.validatePayment(
      verification,
      expectedTxRef: txRef,
      expectedCurrency: 'MWK',
      expectedAmount: 1000,
    );
    
    if (isValid) {
      // Payment is valid, provide value to customer
      print('Payment verified successfully');
      print('Amount paid: ${verification.data.amount}');
      print('Payment channel: ${verification.data.authorization.channel}');
      print('Transaction reference: ${verification.data.txRef}');
    } else {
      // Payment validation failed
      print('Payment validation failed');
    }
  } on PayChanguException catch (e) {
    print('Verification failed: ${e.message}');
    if (e.details != null) {
      print('Error details: ${e.details}');
    }
  }
}
```

## Complete Example

Here's a complete example implementing payment and verification:

```dart
class PaymentScreen extends StatelessWidget {
  final paychangu = PayChangu(
    PayChanguConfig(
      secretKey: 'your_secret_key_here',
      isTestMode: true,
    ),
  );

  Future<void> _handlePaymentSuccess(Map<String, dynamic> response) async {
    try {
      final verification = await paychangu.verifyTransaction(response['tx_ref']);
      final isValid = paychangu.validatePayment(
        verification,
        expectedTxRef: response['tx_ref'],
        expectedCurrency: 'MWK',
        expectedAmount: 1000,
      );

      if (isValid) {
        // Process successful payment
        print('Payment verified: ${verification.data.amount} ${verification.data.currency}');
      }
    } catch (e) {
      print('Verification failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final request = PaymentRequest(
              txRef: 'tx-${DateTime.now().millisecondsSinceEpoch}',
              firstName: 'John',
              lastName: 'Doe',
              email: 'john@example.com',
              currency: Currency.MWK,
              amount: 1000,
              callbackUrl: 'https://your-domain.com/callback',
              returnUrl: 'https://your-domain.com/return',
            );

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: paychangu.launchPayment(
                    request: request,
                    onSuccess: _handlePaymentSuccess,
                    onError: (error) => print('Payment failed: $error'),
                    onCancel: () => print('Payment cancelled'),
                  ),
                ),
              ),
            );
          },
          child: Text('Pay Now'),
        ),
      ),
    );
  }
}
```

## Verification Response Data

The verification response includes detailed transaction information:

```dart
verification.data.status         // Transaction status
verification.data.amount        // Amount paid
verification.data.currency      // Currency used
verification.data.txRef         // Transaction reference
verification.data.authorization.channel    // Payment channel used
verification.data.authorization.provider   // Payment provider
verification.data.customer      // Customer information
verification.data.createdAt     // Transaction creation time
```

## Error Handling

The SDK provides a custom `PayChanguException` class for error handling:

```dart
try {
  final verification = await paychangu.verifyTransaction(txRef);
} on PayChanguException catch (e) {
  print('Error: ${e.message}');
  if (e.details != null) {
    print('Details: ${e.details}');
  }
}
```

## Additional Information

- [PayChangu Documentation](https://paychangu.readme.io/reference)
- [API Reference](https://paychangu.readme.io/reference/level-reference)
- [Support](https://paychangu.com/support)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email support@paychangu.com or visit our [support page](https://paychangu.com/support).
