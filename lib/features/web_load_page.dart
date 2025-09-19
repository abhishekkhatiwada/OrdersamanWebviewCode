import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ordersaman/common/constants/app_config.dart';
import 'package:ordersaman/common/utils/custom_log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class WebLoadPage extends StatefulWidget {
  const WebLoadPage({super.key});

  @override
  State<WebLoadPage> createState() => _WebLoadPageState();
}

class _WebLoadPageState extends State<WebLoadPage> {
  InAppWebViewController? webViewController;
  String? _fcmToken;
  bool _loading = true;
  bool _hasInternet = true;
  final String _phoneNumber = "+9779801320486";

  @override
  void initState() {
    super.initState();
    _initSetup();
  }

  Future<void> _initSetup() async {
    await Firebase.initializeApp();

    // Request permissions
    await [
      Permission.camera,
      Permission.microphone,
      Permission.photos,
      Permission.storage,
      Permission.location,
    ].request();

    // Check internet
    final connectivityResult = await Connectivity().checkConnectivity();
    CustomLog.success(connectivityResult);
    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        _hasInternet = false;
        _loading = false;
      });
      return;
    }

    // Get FCM token
    final token = await FirebaseMessaging.instance.getToken();
    setState(() {
      _fcmToken = token;
      _hasInternet = true;
      _loading = false;
    });
  }

  Future<void> _makeCall() async {
    final Uri callUri = Uri(scheme: 'tel', path: _phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Could not open dialer")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : !_hasInternet
              // No Internet → Show Call Button
              ? Center(
                child: ElevatedButton.icon(
                  onPressed: _makeCall,
                  icon: const Icon(Icons.call),
                  label: Text("Call Us"),
                ),
              )
              // Internet available → Load Web
              : SafeArea(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri(
                      '${AppConfig.current.baseUrl}/?firebaseToken=$_fcmToken',
                    ),
                  ),
                  initialSettings: InAppWebViewSettings(
                    javaScriptEnabled: true,
                    geolocationEnabled: true,
                    mediaPlaybackRequiresUserGesture: false,
                    useOnDownloadStart: true,
                    allowFileAccessFromFileURLs: true,
                    allowUniversalAccessFromFileURLs: true,
                    useHybridComposition: true,
                    allowContentAccess: true,
                    allowFileAccess: true,
                    allowsInlineMediaPlayback: true,
                  ),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onGeolocationPermissionsShowPrompt: (
                    InAppWebViewController controller,
                    String origin,
                  ) async {
                    return GeolocationPermissionShowPromptResponse(
                      origin: origin,
                      allow: true,
                      retain: true,
                    );
                  },
                ),
              ),
    );
  }
}
