// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AddPlantScreen extends StatelessWidget {
//   const AddPlantScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Add Plant',
//           style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SafeArea(
//           child: Form(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Plant Name'),
//                 ),
//                 const SizedBox(height: 16),
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(labelText: 'Plant Type'),
//                   items: const [
//                     DropdownMenuItem(value: 'Indoor', child: Text('Indoor')),
//                     DropdownMenuItem(value: 'Outdoor', child: Text('Outdoor')),
//                   ],
//                   onChanged: (value) {},
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   decoration:
//                       const InputDecoration(labelText: 'Watering Schedule'),
//                 ),
//                 const SizedBox(height: 16),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Add image picker logic
//                     },
//                     child: const Text('Pick Image'),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text('Submit'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_care_app/model/plant_model.dart';
import 'package:plant_care_app/view_model/plant_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPlantScreen extends StatelessWidget {
  const AddPlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    const uuid = Uuid();

    final plantTypes = ['Indoor', 'Outdoor'];
    String? selectedType;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Add Plant',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plant Details',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 45, 96, 49),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Plant Name',
                  labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Plant Type',
                  labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: plantTypes
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  selectedType = value;
                },
                validator: (value) =>
                    value == null ? 'Please select a plant type' : null,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        selectedType != null) {
                      final newPlant = Plant(
                        id: uuid.v4(),
                        name: nameController.text,
                        type: selectedType!,
                        imagePath: 'asset/plant_image.png',
                      );
                      Provider.of<PlantViewModel>(context, listen: false)
                          .addPlant(newPlant);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    backgroundColor: const Color.fromARGB(255, 45, 96, 49),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Add Plant',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
