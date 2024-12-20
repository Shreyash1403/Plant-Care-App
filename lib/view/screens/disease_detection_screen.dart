import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  bool _isScanning = false;
  String? _result;

  void _pickImage() {
    // Simulate picking an image and API processing
    setState(() {
      _isScanning = true;
      _result = null;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isScanning = false;
        _result = "Leaf Blight Detected"; // Replace with actual API result
      });
    });
  }

  void _resetScan() {
    setState(() {
      _isScanning = false;
      _result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
      appBar: AppBar(
        title: Text(
          "Scan for Disease",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 22, 53, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.camera_alt),
              label: Text(
                "Pick Image",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 34, 139, 34),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_isScanning)
              const CircularProgressIndicator()
            else if (_result != null)
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    _result!,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            else
              Text(
                "Select an image to scan for plant diseases.",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(48, 48, 48, 1),
                ),
                textAlign: TextAlign.center,
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: _resetScan,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 22, 53, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                "Scan Again",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_fonts/google_fonts.dart';

// class DiseaseDetectionScreen extends StatefulWidget {
//   const DiseaseDetectionScreen({super.key});

//   @override
//   _DiseaseDetectionScreenState createState() => _DiseaseDetectionScreenState();
// }

// class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
//   bool _isScanning = false;
//   String? _result;

//   // Use this method to simulate picking an image and then scan it
//   void _pickImage() {
//     setState(() {
//       _isScanning = true;
//       _result = null;
//     });

//     Future.delayed(const Duration(seconds: 3), () {
//       setState(() {
//         _isScanning = false;
//         _result = "Leaf Blight Detected"; // This should come from API
//       });
//     });
//   }

//   void _resetScan() {
//     setState(() {
//       _isScanning = false;
//       _result = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
//       appBar: AppBar(
//         title: Text("Scan for Disease",
//             style:
//                 GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
//         backgroundColor: const Color.fromARGB(255, 22, 53, 0),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton.icon(
//               onPressed: _pickImage,
//               icon: const Icon(Icons.camera_alt),
//               label: Text(
//                 "Pick Image",
//                 style: GoogleFonts.poppins(
//                     fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 34, 139, 34)),
//             ),
//             const SizedBox(height: 20),
//             if (_isScanning) const CircularProgressIndicator(),
//             if (_result != null)
//               Card(
//                 color: Colors.white,
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Text(
//                     _result!,
//                     style: GoogleFonts.poppins(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: _resetScan,
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 22, 53, 0)),
//               child: Text("Scan Again",
//                   style: GoogleFonts.poppins(
//                       fontSize: 16, fontWeight: FontWeight.bold)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
