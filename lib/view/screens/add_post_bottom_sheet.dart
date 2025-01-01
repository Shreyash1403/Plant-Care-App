// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_care_app/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class AddPostBottomSheet extends StatefulWidget {
  const AddPostBottomSheet({super.key});

  @override
  _AddPostBottomSheetState createState() => _AddPostBottomSheetState();
}

class _AddPostBottomSheetState extends State<AddPostBottomSheet> {
  final _userNameController = TextEditingController();
  final _captionController = TextEditingController();
  File? _imageFile;

  final _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submit() async {
    if (_userNameController.text.isEmpty ||
        _captionController.text.isEmpty ||
        _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    await postViewModel.addPost(
      userName: _userNameController.text,
      caption: _captionController.text,
      imageFile: _imageFile!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add Post', style: TextStyle(fontSize: 20)),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    _imageFile == null ? null : FileImage(_imageFile!),
                child: _imageFile == null
                    ? const Icon(Icons.add_a_photo, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(labelText: 'User Name'),
            ),
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(labelText: 'Caption'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
