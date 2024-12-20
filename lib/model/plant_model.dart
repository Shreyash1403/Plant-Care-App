class Plant {
  final String id;
  final String name;
  final String type;
  final String imagePath;

  Plant({
    required this.id,
    required this.name,
    required this.type,
    required this.imagePath,
  });

  // Convert Plant object to JSON for storage or API calls
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'imagePath': imagePath,
    };
  }

  // Create a Plant object from JSON
  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      imagePath: json['imagePath'] as String,
    );
  }
}
