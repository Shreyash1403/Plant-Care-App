// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'home_screen_content.dart';
// import 'plants_list_screen.dart';
// import 'community_screen.dart';
// import 'profile_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _screens = [
//     const HomeScreenContent(),
//     const PlantListScreen(),
//     const SizedBox(),
//     const CommunityScreen(),
//     const ProfileScreen(),
//   ];

//   final ImagePicker _picker = ImagePicker();

//   void _onItemTapped(int index) async {
//     if (index == 2) {
//       final XFile? pickedImage = await _picker.pickImage(
//         source: ImageSource.camera,
//       );

//       if (pickedImage != null) {
//         showDialog(
//           // ignore: use_build_context_synchronously
//           context: context,
//           builder: (_) => AlertDialog(
//             title: const Text("Image Selected"),
//             content: Image.file(
//               File(pickedImage.path),
//               fit: BoxFit.cover,
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("OK"),
//               ),
//             ],
//           ),
//         );
//       }
//     } else {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
//       body: _selectedIndex == 2
//           ? const SizedBox.shrink()
//           : _screens[_selectedIndex],
//       bottomNavigationBar: ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(30.0),
//           topRight: Radius.circular(30.0),
//         ),
//         child: BottomNavigationBar(
//           backgroundColor: const Color.fromARGB(255, 22, 53, 0),
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           selectedItemColor: const Color.fromARGB(255, 200, 232, 177),
//           unselectedItemColor: Colors.white,
//           type: BottomNavigationBarType.fixed,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.nature),
//               label: 'Plants',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.document_scanner_outlined),
//               label: 'Scan',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.people_alt_outlined),
//               label: 'Community',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Profile',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_care_app/view/screens/community_screen.dart';
import 'package:plant_care_app/view/screens/home_screen_content.dart';
import 'package:plant_care_app/view/screens/plants_list_screen.dart';
import 'package:plant_care_app/view/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ImagePicker _picker = ImagePicker();

  final List<Widget> _screens = [
    const HomeScreenContent(),
    const PlantListScreen(),
    const SizedBox(),
    const CommunityScreen(),
    const ProfileScreen(),
  ];

  Future<void> _scanImage(File image) async {
    const apiKey = 'ZXTwwtP73DAWgV8jPl9C17lmPYRcWFLlNoH4WdWlCNlpeZH4uz';
    final url = Uri.parse('https://plant.id/api/v3/health_assessment');

    // Convert the image to Base64
    final imageBytes = await image.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    // Prepare the request payload
    final request = {
      'images': [base64Image], // Base64-encoded image
      'latitude': 49.207,
      'longitude': 16.608,
      'similar_images': true,
      'health': 'all', // Includes all health information
      'classification_level': 'species', // Species-level classification
      'symptoms': true // Include symptoms analysis
    };

    try {
      // Make API call
      final response = await http.post(
        url,
        headers: {
          'Api-Key': apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request),
      );

      // Check if response is successful
      // log("response : ${response.body}");
      log("Status code: ${response.statusCode}");
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final result = _parseHealthAssessment(responseData);
        _showScanResult(result);
      } else {
        _showError(
          "Error ${response.statusCode}: ${response.body}",
        );
      }
    } catch (e) {
      _showError("Network error: $e");
    }
  }

  String _parseHealthAssessment(Map<String, dynamic> responseData) {
    log(responseData['result']['disease']['suggestions'].length.toString());
    if (responseData['health_assessment'] == null) {
      return "Could not assess plant health. Please try again with a clearer image.";
    }

    if (responseData['health_assessment']['is_healthy']['binary'] == true) {
      return "The plant is healthy!";
    } else {
      final diseases =
          responseData['health_assessment']['diseases'] as List<dynamic>? ?? [];
      if (diseases.isNotEmpty) {
        final disease = diseases.first;
        return "${disease['name']} detected. Suggested Treatment: ${disease['treatment'] ?? 'Not available'}";
      }
      return "Plant appears unhealthy, but no disease information is available.";
    }
  }

  void _showScanResult(String result) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Scan Result"),
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) async {
    if (index == 2) {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        File image = File(pickedImage.path);
        _scanImage(image);
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
      body: _screens[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 22, 53, 0),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color.fromARGB(255, 200, 232, 177),
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.nature), label: 'Plants'),
            BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner_outlined),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_outlined), label: 'Community'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
