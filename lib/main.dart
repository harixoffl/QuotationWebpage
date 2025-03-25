import 'package:approve_reject_quotation/service/API_services/invoker.dart';
import 'package:approve_reject_quotation/views/screens/webPage.dart';
import 'package:approve_reject_quotation/controllers/webpage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => QuotationController());
  Get.lazyPut(() => ScrollController());
  Get.lazyPut(() => Invoker());

  Uri uri = Uri.base;
  String eventId = uri.queryParameters['event_id'] ?? 'No Event Id Provided';
  String secret = uri.queryParameters['secret'] ?? 'No Session token Provided';

  runApp(MyApp(event_id: eventId, secret: secret));
}

class MyApp extends StatelessWidget {
  final String event_id;
  final String secret;

  const MyApp({super.key, required this.event_id, required this.secret});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Helvetica'),
      initialRoute: '/quotationpage',
      getPages: [GetPage(name: '/quotationpage', page: () => QuotationPage(event_id: event_id, secret: secret))],
    );
  }
}
