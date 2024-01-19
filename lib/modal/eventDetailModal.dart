class EventsDetails {
  final String id;
  final String slug;
  final String meta_title;
  final String meta_description;
  final String heading;
  final String content;
  final String image;
  final String visibility;
  final String created_on;
    final String start_date;
  final String end_date;

  EventsDetails({
    required this.id,
    required this.slug,
    required this.meta_title,
    required this.meta_description,
    required this.heading,
    required this.content,
    required this.image,
    required this.visibility,
    required this.created_on,
      required this.start_date,
    required this.end_date
  });

  factory EventsDetails.fromJson(Map<String, dynamic> json) {
    return EventsDetails(
        id: json['id'] ?? '',
        slug: json['slug'] ?? '',
        meta_title: json['meta_title'] ?? '',
        meta_description: json['meta_description'] ?? '',
        heading: json['heading'] ?? '',
        content: json['content'] ?? '',
        image: json['hero_image'] ?? '',
        visibility: json['visibility'] ?? '',
        created_on: json['created_on'] ?? '',  start_date: json['start_date'] ?? '', end_date:json['end_date'] ?? '',);
  }
}
