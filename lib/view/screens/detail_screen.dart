// import 'package:flutter/material.dart';

// class PlantDetailsScreen extends StatelessWidget {
//   const PlantDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plant Details'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text('Plant Name',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                   SizedBox(height: 8),
//                   Text('Type: Indoor'),
//                   Text('Watering: Every 2 Days'),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ListTile(
//             title: const Text('Add Log'),
//             trailing: const Icon(Icons.add),
//             onTap: () {
//               // Add log logic
//             },
//           ),
//           const ListTile(
//             title: Text('Scan for Disease'),
//             trailing: Icon(Icons.camera_alt),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlantDetailsScreen extends StatelessWidget {
  const PlantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
      body: Column(
        children: [
          // Header section with image
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/plant.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Plant name
                    Text(
                      'Papaver Somniferum',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Tags
                    Row(
                      children: [
                        _buildTag('Indoor'),
                        _buildTag('Pet friendly'),
                        _buildTag('Papaveraceae'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Description
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'From Wikipedia, the free encyclopedia\n\nPapaver somniferum, commonly known as the opium poppy or breadseed poppy, is a species of flowering plant in the family Papaveraceae. It is the species of plant from which both opium and poppy seeds are derived...',
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 20),
                    // Characteristics
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCharacteristic(Icons.height, 'Height', 'Small'),
                        _buildCharacteristic(
                            Icons.water_drop, 'Water', '333ml'),
                        _buildCharacteristic(Icons.wb_sunny, 'Light', 'Normal'),
                        _buildCharacteristic(
                            Icons.thermostat, 'Humidity', '56%'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your action here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Save this plant',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(204, 231, 185, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.jost(fontSize: 14, color: Colors.black),
      ),
    );
  }

  Widget _buildCharacteristic(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.green),
        const SizedBox(height: 5),
        Text(
          title,
          style: GoogleFonts.jost(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: GoogleFonts.jost(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }
}
