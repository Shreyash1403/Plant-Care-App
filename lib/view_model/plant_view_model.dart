// import 'package:flutter/material.dart';
// import 'package:plant_care_app/model/plant_model.dart';

// class PlantViewModel with ChangeNotifier {
//   final List<Plant> _plants = [];

//   // Getter to access the plants
//   List<Plant> get plants => List.unmodifiable(_plants);

//   // Add a new plant
//   void addPlant(Plant plant) {
//     _plants.add(plant);
//     notifyListeners();
//   }

//   // Update an existing plant
//   void updatePlant(String id, Plant updatedPlant) {
//     final index = _plants.indexWhere((plant) => plant.id == id);
//     if (index != -1) {
//       _plants[index] = updatedPlant;
//       notifyListeners();
//     }
//   }

//   // Delete a plant by ID
//   void deletePlant(String id) {
//     _plants.removeWhere((plant) => plant.id == id);
//     notifyListeners();
//   }

//   // Fetch plants (can be modified to fetch from an API or local storage)
//   void fetchPlants(List<Plant> fetchedPlants) {
//     _plants.clear();
//     _plants.addAll(fetchedPlants);
//     notifyListeners(); // Notify UI to rebuild
//   }
// }

///////////////

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../model/plant_model.dart';

class PlantViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<Plant> _plants = [];
  bool _isLoading = false;

  List<Plant> get plants => _plants;
  bool get isLoading => _isLoading;

  Future<void> fetchPlants() async {
    log('Fetching plants...');
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot = await _firestore.collection('plants').get();
      _plants = snapshot.docs.map((doc) {
        final data = doc.data();
        return Plant.fromFirestore(data, doc.id);
      }).toList();
      log('Plants fetched: ${_plants.length}');
    } catch (e) {
      log('Error fetching plants: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPlant(Plant plant, String imagePath) async {
    try {
      log('Uploading image for plant: ${plant.name}');
      final storageRef = _storage.ref().child('plant_images/${plant.id}.jpg');
      await storageRef.putFile(File(imagePath));
      final imageUrl = await storageRef.getDownloadURL();

      log('Image uploaded successfully. URL: $imageUrl');

      final newPlant = Plant(
        id: plant.id,
        name: plant.name,
        type: plant.type,
        imageUrl: imageUrl,
      );

      log('Saving plant to Firestore');
      await _firestore
          .collection('plants')
          .doc(plant.id)
          .set(newPlant.toFirestore());

      log('Plant saved to Firestore');
      _plants.add(newPlant);
      notifyListeners();
    } catch (e) {
      log('Error in addPlant: $e');
      rethrow;
    }
  }
}
