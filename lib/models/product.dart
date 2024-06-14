class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    this.isFavorite = false,
  });

  Product copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
