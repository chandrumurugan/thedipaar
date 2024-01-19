class SponsorList {
  final String id;
  final String name;
  final String image;
  final String status;
  final String link;
  final String createdAt;
  final String updatedAt;

  SponsorList({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SponsorList.fromJson(Map<String, dynamic> json) {
    return SponsorList(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      link: json['link'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
