class CategoryModal {
  final String name;
  final String url;
  final String slug;
  final String thumbnail;

  CategoryModal({
    required this.name,
    required this.url,
    required this.slug,
    required this.thumbnail,
  });

  // Factory constructor to create a CategoryModal from JSON
  factory CategoryModal.fromJson(Map<String, dynamic> json, String thumbnail) {
    return CategoryModal(
      slug: json['slug'] ?? '',
      name: json['name'],
      url: json['url'],
      thumbnail: thumbnail,
    );
  }
}
