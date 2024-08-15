class Blog {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final bool isFavorite;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'is_favorite': isFavorite ? 1 : 0,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      imageUrl: map['image_url'],
      isFavorite: map['is_favorite'] == 1,
    );
  }

  Blog copyWith({
    int? id,
    String? title,
    String? content,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Blog(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}