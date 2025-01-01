class PostModel {
  final String id;
  final String userName;
  final String caption;
  final String imageUrl;

  PostModel({
    required this.id,
    required this.userName,
    required this.caption,
    required this.imageUrl,
  });

  factory PostModel.fromFirestore(Map<String, dynamic> data, String id) {
    return PostModel(
      id: id,
      userName: data['userName'] ?? '',
      caption: data['caption'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userName': userName,
      'caption': caption,
      'imageUrl': imageUrl,
    };
  }
}
