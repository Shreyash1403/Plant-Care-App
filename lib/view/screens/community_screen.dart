import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_care_app/widgets/custom_card.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String _searchQuery = '';
  final List<Map<String, String>> _posts = List.generate(
    10,
    (index) => {
      'image': 'https://via.placeholder.com/150', // Replace with post image URL
      'userName': 'User $index',
      'caption': 'This is a caption for post $index',
      'timestamp': '${index + 1} hours ago',
    },
  );

  @override
  Widget build(BuildContext context) {
    final filteredPosts = _posts
        .where((post) =>
            post['caption']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(251, 247, 248, 1),
        title: Text(
          'Community',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search posts...',
                hintStyle: GoogleFonts.poppins(),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredPosts.length,
        itemBuilder: (context, index) {
          final post = filteredPosts[index];
          return CustomCard(
            child: Card(
              color: const Color.fromARGB(255, 211, 236, 194),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    post['image']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['userName']!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          post['caption']!,
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          post['timestamp']!,
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Handle like action
                              },
                              icon: const Icon(Icons.thumb_up_outlined),
                              tooltip: 'Like',
                            ),
                            IconButton(
                              onPressed: () {
                                // Handle comment action
                              },
                              icon: const Icon(Icons.comment_outlined),
                              tooltip: 'Comment',
                            ),
                            IconButton(
                              onPressed: () {
                                // Handle share action
                              },
                              icon: const Icon(Icons.share_outlined),
                              tooltip: 'Share',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(204, 231, 185, 1),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 0, 46, 2),
        ),
      ),
    );
  }
}
