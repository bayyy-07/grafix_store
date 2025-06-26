import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MidtransPaymentPage extends StatefulWidget {
  final String snapToken;

  const MidtransPaymentPage({super.key, required this.snapToken});

  @override
  State<MidtransPaymentPage> createState() => _MidtransPaymentPageState();
}

class _MidtransPaymentPageState extends State<MidtransPaymentPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final snapUrl = "https://app.sandbox.midtrans.com/snap/v4/redirection/${widget.snapToken}";
    debugPrint("Mulai pembayaran");
    debugPrint("Snap Token: ${widget.snapToken}");
    debugPrint("Navigasi ke: $snapUrl");

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          debugPrint("Mulai buka halaman: $url");
        },
        onPageFinished: (url) {
          debugPrint("Halaman selesai dimuat: $url");
        },
        onNavigationRequest: (request) {
          final url = request.url;
          if (url.contains('finish') || url.contains('success')) {
            if (mounted) Navigator.pop(context, true);
            return NavigationDecision.prevent;
          } else if (url.contains('unfinish') || url.contains('failed')) {
            if (mounted) Navigator.pop(context, false);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
       onWebResourceError: (error) {
  debugPrint("WebResourceError: ${error.errorCode}, ${error.description}");
}

      ))
      ..loadRequest(Uri.parse(snapUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
