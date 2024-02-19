


class EventsList {
  final String id;
  final String slug;
  final String metaTitle;
  final String metaDescription;
  final String heading;
  final String heroImage;
  final String visibility;
  final String createdOn;
  final String updatedOn;
  final DateTime startDate;
  final DateTime endDate;
  final String gmap;

  EventsList({
    required this.id,
    required this.slug,
    required this.metaTitle,
    required this.metaDescription,
    required this.heading,
    required this.heroImage,
    required this.visibility,
    required this.createdOn,
    required this.updatedOn,
    required this.startDate,
    required this.endDate,
    required this.gmap
  });

  factory EventsList.fromJson(Map<String, dynamic> json) {
    return EventsList(
      id: json['id'] ?? '',
      slug: json['slug'] ?? '',
      metaTitle: json['meta_title'] ?? '',
      metaDescription: json['meta_description'] ?? '',
      heading: json['heading'] ?? '',
      heroImage: json['hero_image'] ?? '',
      visibility: json['visibility'] ?? '',
      createdOn: json['created_on'] ?? '',
      updatedOn: json['updated_on'] ?? '',
      startDate: DateTime.parse(json['start_date'] ?? ''),
      endDate: DateTime.parse(json['end_date'] ?? ''), gmap: json['gmap'] ?? '',
    );
  }
}

