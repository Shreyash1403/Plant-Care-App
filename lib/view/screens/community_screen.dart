// // ignore_for_file: library_private_types_in_public_api

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:plant_care_app/model/post_model.dart';
// import 'package:plant_care_app/view_model/post_view_model.dart';
// import 'package:plant_care_app/widgets/custom_card.dart';
// import 'package:provider/provider.dart';

// class CommunityScreen extends StatefulWidget {
//   const CommunityScreen({super.key});

//   @override
//   _CommunityScreenState createState() => _CommunityScreenState();
// }

// class _CommunityScreenState extends State<CommunityScreen> {
//   String _searchQuery = '';
//   final List<Map<String, String>> _posts = List.generate(
//     10,
//     (index) => {
//       'image': 'https://via.placeholder.com/150', // Replace with post image URL
//       'userName': 'User $index',
//       'caption': 'This is a caption for post $index',
//       'timestamp': '${index + 1} hours ago',
//     },
//   );

//   final TextEditingController _userNameController = TextEditingController();
//   final TextEditingController _captionController = TextEditingController();

//   final ImagePicker _imagePicker = ImagePicker();
//   XFile? _selectedFile;

//   void _addPost() {
//     if (_captionController.text.isEmpty ||
//         _selectedFile == null ||
//         _userNameController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Please fill all fields and select an image')),
//       );
//       return;
//     }

//     final newPost = PostModel(
//         userName: _userNameController.text,
//         caption: _captionController.text,
//         imageUrl: '',
//         id: '');

//      Provider.of<PostViewModel>(context,listen: false).addPost(newPost);
//   }

//   void _showPostBottomSheet() {
//     showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 left: 16,
//                 right: 16,
//                 top: 16,
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Add Post',
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     _selectedFile = await _imagePicker.pickImage(
//                         source: ImageSource.gallery);
//                     if (_selectedFile != null) {
//                       setState(() {});
//                     }
//                   },
//                   child: Container(
//                     width: 120,
//                     height: 120,
//                     clipBehavior: Clip.antiAlias,
//                     decoration: BoxDecoration(
//                       color: Colors.amber,
//                       borderRadius: BorderRadius.circular(60),
//                     ),
//                     child: (_selectedFile == null)
//                         ? const Icon(
//                             Icons.image,
//                             color: Colors.white,
//                             size: 50,
//                           )
//                         : Image.file(
//                             File(_selectedFile!.path),
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   controller: _userNameController,
//                   decoration: InputDecoration(
//                     labelText: 'User Name',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: _captionController,
//                   decoration: InputDecoration(
//                     labelText: 'Caption',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                     onPressed: _addPost,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromRGBO(62, 102, 24, 1),
//                     ),
//                     child: const Text(
//                       'Add Post',
//                       style: TextStyle(color: Colors.white),
//                     ))
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredPosts = _posts
//         .where((post) =>
//             post['caption']!.toLowerCase().contains(_searchQuery.toLowerCase()))
//         .toList();

//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
//         title: Text(
//           'Community',
//           style: GoogleFonts.poppins(
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//             color: Colors.black,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(56.0),
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: TextFormField(
//               onChanged: (value) {
//                 setState(() {
//                   _searchQuery = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search posts...',
//                 hintStyle: GoogleFonts.poppins(),
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: filteredPosts.length,
//         itemBuilder: (context, index) {
//           final post = filteredPosts[index];
//           return CustomCard(
//             child: Card(
//               color: const Color.fromARGB(255, 211, 236, 194),
//               margin: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.network(
//                     post['image']!,
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: 200,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           post['userName']!,
//                           style: GoogleFonts.poppins(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           post['caption']!,
//                           style: GoogleFonts.poppins(fontSize: 14),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           post['timestamp']!,
//                           style: GoogleFonts.poppins(
//                             color: Colors.grey,
//                             fontSize: 12,
//                           ),
//                         ),
//                         const Divider(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 // Handle like action
//                               },
//                               icon: const Icon(Icons.thumb_up_outlined),
//                               tooltip: 'Like',
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 // Handle comment action
//                               },
//                               icon: const Icon(Icons.comment_outlined),
//                               tooltip: 'Comment',
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 // Handle share action
//                               },
//                               icon: const Icon(Icons.share_outlined),
//                               tooltip: 'Share',
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color.fromRGBO(204, 231, 185, 1),
//         onPressed: () {
//           _showPostBottomSheet();
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
import 'package:plant_care_app/view_model/post_view_model.dart';
import 'package:provider/provider.dart';
import 'add_post_bottom_sheet.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postViewModel = Provider.of<PostViewModel>(context);

    // Call fetchPosts when the screen loads for the first time.
    Future<void> _loadPosts() async {
      await postViewModel.fetchPosts(); // Fetch posts from Firebase.
    }

    // Automatically fetch posts when the screen loads.
    if (postViewModel.posts.isEmpty) {
      _loadPosts();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Community')),
      body: postViewModel.posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: postViewModel.posts.length,
              itemBuilder: (context, index) {
                final post = postViewModel.posts[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      post.imageUrl.isNotEmpty
                          ? Image.network(post.imageUrl, fit: BoxFit.cover)
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(post.caption,
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddPostBottomSheet(),
          ).whenComplete(() => postViewModel
              .fetchPosts()); // Reload posts after adding a new post.
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
