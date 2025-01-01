// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:plant_care_app/model/plant_model.dart';
// import 'package:plant_care_app/view_model/plant_view_model.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';

// class AddPlantScreen extends StatelessWidget {
//   const AddPlantScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final nameController = TextEditingController();
//     const uuid = Uuid();

//     final plantTypes = ['Indoor', 'Outdoor'];
//     String? selectedType;

//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: Text(
//           'Add Plant',
//           style: GoogleFonts.poppins(
//               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Plant Details',
//                 style: GoogleFonts.poppins(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: const Color.fromARGB(255, 45, 96, 49),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Plant Name',
//                   labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 style: GoogleFonts.poppins(fontSize: 16),
//               ),
//               const SizedBox(height: 16),
//               DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   labelText: 'Plant Type',
//                   labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 items: plantTypes
//                     .map(
//                       (type) => DropdownMenuItem(
//                         value: type,
//                         child: Text(
//                           type,
//                           style: GoogleFonts.poppins(fontSize: 16),
//                         ),
//                       ),
//                     )
//                     .toList(),
//                 onChanged: (value) {
//                   selectedType = value;
//                 },
//                 validator: (value) =>
//                     value == null ? 'Please select a plant type' : null,
//               ),
//               const SizedBox(height: 24),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (nameController.text.isNotEmpty &&
//                         selectedType != null) {
//                       final newPlant = Plant(
//                         id: uuid.v4(),
//                         name: nameController.text,
//                         type: selectedType!,
//                         imagePath: 'asset/plant_image.png',
//                       );
//                       Provider.of<PlantViewModel>(context, listen: false)
//                           .addPlant(newPlant);
//                       Navigator.pop(context);
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Please fill all fields')),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 32, vertical: 12),
//                     backgroundColor: const Color.fromARGB(255, 45, 96, 49),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     'Add Plant',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_care_app/model/plant_model.dart';
import 'package:plant_care_app/view_model/plant_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final TextEditingController nameController = TextEditingController();
  final String id = const Uuid().v4();
  final List<String> plantTypes = ['Indoor', 'Outdoor'];
  String? selectedType;
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  void _addPlant() {
    if (nameController.text.isEmpty ||
        selectedType == null ||
        _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and select an image')),
      );
      return;
    }

    final newPlant = Plant(
      id: id,
      name: nameController.text,
      type: selectedType!,
      imageUrl: '',
    );

    log('Attempting to add plant: ${newPlant.name}, ${newPlant.type}');
    Provider.of<PlantViewModel>(context, listen: false)
        .addPlant(newPlant, _pickedImage!.path)
        .then((_) {
      log('Plant added successfully');

      Provider.of<PlantViewModel>(context, listen: false).fetchPlants();
      Navigator.pop(context);
    }).catchError((error) {
      log('Error adding plant: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add plant: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Plant')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Plant Name'),
            TextField(controller: nameController),
            const SizedBox(height: 16),
            const Text('Plant Type'),
            DropdownButtonFormField(
              value: selectedType,
              items: plantTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Plant Image'),
            _pickedImage != null
                ? Image.file(File(_pickedImage!.path), height: 150)
                : const SizedBox.shrink(),
            TextButton(onPressed: _pickImage, child: const Text('Pick Image')),
            const Spacer(),
            ElevatedButton(
              onPressed: _addPlant,
              child: const Text('Add Plant'),
            ),
          ],
        ),
      ),
    );
  }
}
