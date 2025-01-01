// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:plant_care_app/view_model/plant_view_model.dart';
// import 'package:provider/provider.dart';
// import 'package:plant_care_app/widgets/custom_card.dart';

// class PlantListScreen extends StatelessWidget {
//   const PlantListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final plantViewModel = Provider.of<PlantViewModel>(context);

//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
//       appBar: AppBar(
//         title: Text(
//           'Plants',
//           style: GoogleFonts.poppins(
//               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: plantViewModel.plants.isNotEmpty
//               ? GridView.builder(
//                   itemCount: plantViewModel.plants.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16.0,
//                     mainAxisSpacing: 16.0,
//                   ),
//                   itemBuilder: (context, index) {
//                     final plant = plantViewModel.plants[index];
//                     return CustomCard(
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.pushNamed(context, '/plant-details',
//                               arguments: plant);
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               plant.imagePath,
//                               height: 80,
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               plant.name,
//                               style: GoogleFonts.poppins(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               plant.type,
//                               style: GoogleFonts.poppins(
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 )
//               : const Center(child: Text('No plants available')),
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
import 'package:plant_care_app/widgets/custom_card.dart';
import 'package:provider/provider.dart';

class PlantListScreen extends StatefulWidget {
  const PlantListScreen({Key? key}) : super(key: key);

  @override
  State<PlantListScreen> createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlantViewModel>(context, listen: false).fetchPlants();
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Consumer<PlantViewModel>(
          builder: (context, plantViewModel, child) {
            if (plantViewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (plantViewModel.plants.isEmpty) {
              return const Center(child: Text('No plants available.'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
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
                          Image.network(
                            plant.imageUrl,
                            height: 80,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
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
              ),
            );
          },
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
