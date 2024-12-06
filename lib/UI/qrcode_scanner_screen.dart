import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrcodeScannerScreen extends StatefulWidget {
  const QrcodeScannerScreen({super.key});

  @override
  State<QrcodeScannerScreen> createState() => _QrcodeScannerScreenState();
}

class _QrcodeScannerScreenState extends State<QrcodeScannerScreen> {
  MobileScannerController _controller = MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates, returnImage: true);
  String? barcodeValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
          context: context,
          builder: (context) => CustomSnackbar(),
          backgroundColor: Colors.transparent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(
              Icons.arrow_back_ios,
            )),
            Text('Scan QR Code', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800
            ),),
          ],
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              _handleQrDetection(capture);
            },
          ),
          Center(
            child: CustomPaint(
              size: Size(250, 250),
              painter: SmoothRoundedPainter(),
            ),
          ),
          Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Point QRcode into the box",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ))
        ],
      ),
    );
  }

  void _handleQrDetection(BarcodeCapture capture) {
    final Uint8List? image = capture.image;
    final List<Barcode> value = capture.barcodes;

    for (final barcode in value) {
      barcodeValue = barcode.rawValue!;
    }
    if (image != null) {
      _controller.stop();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("QR Code Detected"),
              const SizedBox(height: 10),
              Image.memory(image),
              Text(barcodeValue!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: barcodeValue!));
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.copy),
                        Text("Copy"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _controller.start();
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.close),
                        Text("Close"),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}

class SmoothRoundedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path();
    const double cornerSize = 20;

    // Sudut kiri atas
    path.moveTo(0, cornerSize);
    path.lineTo(0, 0);
    path.lineTo(cornerSize, 0);

    // Sudut kanan atas
    path.moveTo(size.width - cornerSize, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, cornerSize);

    // Sudut kiri bawah
    path.moveTo(0, size.height - cornerSize);
    path.lineTo(0, size.height);
    path.lineTo(cornerSize, size.height);

    // Sudut kanan bawah
    path.moveTo(size.width - cornerSize, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - cornerSize);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomSnackbar extends StatelessWidget {
  const CustomSnackbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Scan QR Code",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Place QR code inside the frame to scan. Please avoid shake to get results quickly.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.asset(
              'assets/images/scan-icon.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
