import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../model/post_model.dart';

class PostViewModel with ChangeNotifier {
  final List<PostModel> _posts = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<PostModel> get posts => List.unmodifiable(_posts);

  Future<void> fetchPosts() async {
    try {
      final snapshot = await _firestore.collection('posts').get();
      _posts.clear();
      _posts.addAll(
        snapshot.docs.map(
          (doc) => PostModel.fromFirestore(doc.data(), doc.id),
        ),
      );
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching posts: $e");
    }
  }

  Future<void> addPost({
    required String userName,
    required String caption,
    required File imageFile,
  }) async {
    try {
      //final storageRef = _storage.ref().child('posts/${DateTime.now().toIso8601String()}');
      //final uploadTask = await storageRef.putFile(imageFile);

      final uploadTask = await FirebaseStorage.instance
          .ref()
          .child('posts')
          .putFile(imageFile);

      final imageUrl = await uploadTask.ref.getDownloadURL();

      final postId = _firestore.collection('posts').doc().id;
      final newPost = PostModel(
        id: postId,
        userName: userName,
        caption: caption,
        imageUrl: imageUrl,
      );

      await _firestore
          .collection('posts')
          .doc(postId)
          .set(newPost.toFirestore());
      _posts.add(newPost);
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding post: $e");
    }
  }
}
