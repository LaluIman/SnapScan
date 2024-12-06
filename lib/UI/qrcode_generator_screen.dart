import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QrcodeGeneratorScreen extends StatefulWidget {
  const QrcodeGeneratorScreen({super.key});

  @override
  State<QrcodeGeneratorScreen> createState() => _QrcodeGeneratorScreenState();
}

class _QrcodeGeneratorScreenState extends State<QrcodeGeneratorScreen> {
  String? qrRawValue;
  Color qrColor = Colors.black;
  final List<String> qrTypes = [
    'JPG',
    'PNG',
    'SVG',
    'PDF'
  ];
  String? selectedQRType;

  ScreenshotController screenShotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
            Text('Generate QR', style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w800
            ),),
          ],
        ),
        backgroundColor: Color(0xFF42ADFE),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 300,
                color: Color(0xFF42ADFE)
              ),
              Expanded(child: Container(
                color: Colors.white,
              )),
            ],
          ),
          Padding(
           padding: const EdgeInsets.only(top: 50),
           child: SingleChildScrollView(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Container(
                   margin: const EdgeInsets.symmetric(horizontal: 20),
                   padding: const EdgeInsets.only(
                       top: 30, left: 20, right: 20, bottom: 0),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(16),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.1),
                         blurRadius: 10,
                         offset: const Offset(0, 5),
                       ),
                     ],
                   ),
                   child: Column(
                     children: [
                       Screenshot(
                         controller: screenShotController,
                         child: Container(
                           padding: const EdgeInsets.all(10),
                           decoration: qrRawValue == null
                               ? null
                               : BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(12),
                                 ),
                           child: qrRawValue == null
                               ? const Text(
                                   "No QR Code Generated",
                                   style: TextStyle(
                                     color: Colors.grey,
                                     fontSize: 16,
                                     fontStyle: FontStyle.italic,
                                   ),
                                 )
                               : Container(
                                   padding: const EdgeInsets.all(10),
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(12),
                                     boxShadow: const [
                                       BoxShadow(
                                         color: Colors.black26,
                                         blurRadius: 10,
                                         offset: Offset(0, 4),
                                       ),
                                     ],
                                   ),
                                   child: PrettyQr(
                                     data: qrRawValue!,
                                     size: 150,
                                     roundEdges: true,
                                     elementColor: qrColor,
                                   ),
                                 ),
                         ),
                       ),
                       const SizedBox(height: 25),
                       TextField(
                         decoration: const InputDecoration(
                           labelText: "Link",
                           hintText: "Insert link here...",
                           border: OutlineInputBorder(),
                         ),
                         onChanged: (value) {
                          setState(() {
                            qrRawValue = value;
                          });
                         },
                       ),
                       const SizedBox(height: 20),
                       ConstrainedBox(
                         constraints: const BoxConstraints(maxHeight: 56),
                         child: DropdownButtonHideUnderline(
                           child: InputDecorator(
                             decoration: const InputDecoration(
                               labelText: "QR Code Type",
                               border: OutlineInputBorder(),
                             ),
                             child: DropdownButton<String>(
                               value: selectedQRType,
                               hint: const Text('Select QR Code Type'),
                               isExpanded: true,
                               isDense: true,
                               items: qrTypes.map((type) {
                                 return DropdownMenuItem<String>(
                                   value: type,
                                   child: Text(type),
                                 );
                               }).toList(),
                               onChanged: (value) {
                                setState(() {
                                  selectedQRType = value;
                                });
                               },
                             ),
                           ),
                         ),
                       ),
                       const SizedBox(height: 30),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           for (var color in [
                             Colors.grey,
                             Colors.orange,
                             Colors.yellow,
                             Colors.green,
                             Colors.cyan,
                             Colors.purple
                           ])
                             GestureDetector(
                               onTap: () {
                                setState(() {
                                  qrColor = color;
                                });
                               },
                               child: Container(
                                 margin:
                                     const EdgeInsets.symmetric(horizontal: 2),
                                 width: 20,
                                 height: 20,
                                 decoration: BoxDecoration(
                                   color: color,
                                   shape: BoxShape.rectangle,
                                   borderRadius: BorderRadius.circular(5),
                                   border: Border.all(
                                     color: qrColor == color
                                         ? Colors.white
                                         : Colors.transparent,
                                   ),
                                 ),
                               ),
                             ),
                         ],
                       ),
                       const SizedBox(height: 30),
                       Container(
                         width: double.infinity,
                         color: Colors.grey.shade300,
                         height: 1,
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Expanded(
                             child: TextButton(
                               onPressed: () {
                                  setState(() {
                                    qrRawValue = null;
                                    selectedQRType = null;
                                  });
                               },
                               child: const Text(
                                 "Cancel",
                                 style: TextStyle(
                                   color: Colors.red,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                           ),
                           Container(
                             width: 1,
                             color: Colors.grey.shade300,
                             height: 50,
                           ),
                           Expanded(
                             child: TextButton(
                               onPressed: (){
                                setState(() {
                                  _shareQrCode();
                                });
                               },
                               child: const Text(
                                 "Share",
                                 style: TextStyle(
                                   color: Colors.green,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
                 const SizedBox(height: 20),
               ],
             ),
           ),
         ),
        ],
      ),
    );
  }

   Future<void> _shareQrCode() async {
   // ambil screenshot dari QR
   final image = await screenShotController.capture();
   if (image != null) {
     await Share.shareXFiles([
       XFile.fromData(
         image,
         name: "qr_code.png", 
         mimeType: "image/png",
       ),
     ]);
   }
 }
}

