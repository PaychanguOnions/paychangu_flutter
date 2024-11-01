import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../config/paychangu_config.dart';
import '../models/payment_request.dart';
import '../core/paychangu.dart';

/// WebView widget for payment checkout
class PayChanguWebView extends StatefulWidget {
  final PaymentRequest request;
  final PayChanguConfig config;
  final Function(Map<String, dynamic>) onSuccess;
  final Function(String) onError;
  final Function() onCancel;

  const PayChanguWebView({
    Key? key,
    required this.request,
    required this.config,
    required this.onSuccess,
    required this.onError,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<PayChanguWebView> createState() => _PayChanguWebViewState();
}

class _PayChanguWebViewState extends State<PayChanguWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: _handleNavigationRequest,
      ));
    _initializePayment();
  }

  NavigationDecision _handleNavigationRequest(NavigationRequest request) {
    if (request.url.startsWith(widget.request.callbackUrl)) {
      _handleCallback(request.url);
      return NavigationDecision.prevent;
    }
    if (request.url.startsWith(widget.request.returnUrl)) {
      widget.onCancel();
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }

  Future<void> _initializePayment() async {
    try {
      final paychangu = PayChangu(widget.config);
      final response = await paychangu.initiatePayment(widget.request);
      final checkoutUrl = response['data']['checkout_url'];
      await _controller.loadRequest(Uri.parse(checkoutUrl));
    } catch (e) {
      widget.onError(e.toString());
    }
  }

  void _handleCallback(String url) {
    final uri = Uri.parse(url);
    final params = uri.queryParameters;
    
    if (params['status'] == 'success') {
      widget.onSuccess(params);
    } else {
      widget.onError('Payment failed: ${params['message'] ?? 'Unknown error'}');
    }
  }
} 