import 'package:flutter/material.dart';
import 'package:plant_care_app/model/plant_model.dart';

class PlantViewModel with ChangeNotifier {
  final List<Plant> _plants = [];

  // Getter to access the plants
  List<Plant> get plants => List.unmodifiable(_plants);

  // Add a new plant
  void addPlant(Plant plant) {
    _plants.add(plant);
    notifyListeners();
  }

  // Update an existing plant
  void updatePlant(String id, Plant updatedPlant) {
    final index = _plants.indexWhere((plant) => plant.id == id);
    if (index != -1) {
      _plants[index] = updatedPlant;
      notifyListeners();
    }
  }

  // Delete a plant by ID
  void deletePlant(String id) {
    _plants.removeWhere((plant) => plant.id == id);
    notifyListeners();
  }

  // Fetch plants (can be modified to fetch from an API or local storage)
  void fetchPlants(List<Plant> fetchedPlants) {
    _plants.clear();
    _plants.addAll(fetchedPlants);
    notifyListeners(); // Notify UI to rebuild
  }
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:plant_care_app/model/plant_model.dart';

// class PlantViewModel with ChangeNotifier {
//   final List<Plant> _plants = [];
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Getter for plants
//   List<Plant> get plants => List.unmodifiable(_plants);

//   // Add a plant to Firestore
//   Future<void> addPlant(Plant plant) async {
//     try {
//       await _firestore.collection('plants').doc(plant.id).set({
//         'id': plant.id,
//         'name': plant.name,
//         'type': plant.type,
//         'imagePath': plant.imagePath,
//       });
//       _plants.add(plant);
//       notifyListeners();
//     } catch (e) {
//       debugPrint('Error adding plant: $e');
//     }
//   }

//   // Fetch plants from Firestore
//   Future<void> fetchPlants() async {
//     try {
//       final snapshot = await _firestore.collection('plants').get();
//       _plants.clear();
//       for (var doc in snapshot.docs) {
//         _plants.add(Plant(
//           id: doc['id'],
//           name: doc['name'],
//           type: doc['type'],
//           imagePath: doc['imagePath'],
//         ));
//       }
//       notifyListeners();
//     } catch (e) {
//       debugPrint('Error fetching plants: $e');
//     }
//   }
// }
