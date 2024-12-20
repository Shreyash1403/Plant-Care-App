// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:plant_care_app/view/widgets/custom_card.dart';

// class PlantListScreen extends StatefulWidget {
//   const PlantListScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _PlantListScreenState createState() => _PlantListScreenState();
// }

// class _PlantListScreenState extends State<PlantListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Plants',
//           style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16.0,
//             mainAxisSpacing: 16.0,
//           ),
//           itemCount: 6,
//           itemBuilder: (context, index) {
//             return CustomCard(
//               child: InkWell(
//                 onTap: () {
//                   Navigator.pushNamed(context, '/plant-details');
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'asset/plant_image.png',
//                       height: 80,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Plant Name',
//                       style: GoogleFonts.poppins(
//                           fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'Plant Type',
//                       style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color.fromRGBO(204, 231, 185, 1),
//         onPressed: () {
//           Navigator.pushNamed(context, '/add-plant');
//         },
//         child: const Icon(
//           Icons.add,
//           color: Color.fromARGB(255, 0, 46, 2),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_care_app/view_model/plant_view_model.dart';
import 'package:provider/provider.dart';
import 'package:plant_care_app/widgets/custom_card.dart';

class PlantListScreen extends StatelessWidget {
  const PlantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plantViewModel = Provider.of<PlantViewModel>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
      appBar: AppBar(
        title: Text(
          'Plants',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: plantViewModel.plants.isNotEmpty
              ? GridView.builder(
                  itemCount: plantViewModel.plants.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemBuilder: (context, index) {
                    final plant = plantViewModel.plants[index];
                    return CustomCard(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/plant-details',
                              arguments: plant);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              plant.imagePath,
                              height: 80,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              plant.name,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              plant.type,
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text('No plants available')),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(204, 231, 185, 1),
        onPressed: () {
          Navigator.pushNamed(context, '/add-plant');
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 0, 46, 2),
        ),
      ),
    );
  }
}
