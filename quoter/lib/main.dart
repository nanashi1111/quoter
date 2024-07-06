import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/screen/route/go_route.dart';
import 'package:quoter/utils/admob_helper.dart';

void main() async {
  await configInstances();
  runApp(const MyApp());
  AdmobHelper.instance.initSdk();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
        canvasColor: Colors.white,///here
      ),
      debugShowCheckedModeBanner: false,
    );

  }
}
