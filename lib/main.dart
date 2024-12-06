import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_scanner/UI/home_screen.dart';
import 'package:qrcode_scanner/UI/qrcode_generator_screen.dart';
import 'package:qrcode_scanner/UI/qrcode_scanner_screen.dart';
import 'package:qrcode_scanner/UI/splash_screen.dart';

void main() {
  runApp(DevicePreview(enabled: true, builder: (context) => const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Manrope",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/create': (context) => QrcodeGeneratorScreen(),
        '/scan': (context) => QrcodeScannerScreen(),
      },
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}
