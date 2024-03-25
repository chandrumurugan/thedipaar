class EventDetails {
  final String id;
  final String slug;
  final String metaTitle;
  final String metaDescription;
  final String heading;
  final String content;
  final String heroImage;
  final String venue; // Might be nullable
  final String gmap; // Might be nullable
  final DateTime startDate;
  final DateTime endDate;
  final String visibility;
  final String createdOn;
  final String updatedOn;
  final List<dynamic> gallery;
    final Previous? previous;
  final Next? next;

  EventDetails({
    required this.id,
    required this.slug,
    required this.metaTitle,
    required this.metaDescription,
    required this.heading,
    required this.content,
    required this.heroImage,
    required this.venue,
    required this.gmap,
    required this.startDate,
    required this.endDate,
    required this.visibility,
    required this.createdOn,
    required this.updatedOn,
    required this.gallery,
  required  this.previous,required this.next, 
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) {
    return EventDetails(
      id: json['id'] ?? '',
      slug: json['slug'] ?? '',
      metaTitle: json['meta_title'] ?? '',
      metaDescription: json['meta_description'] ?? '',
      heading: json['heading'] ?? '',
      content: json['content'] ?? '',
      heroImage: json['hero_image'] ?? '',
      venue: json['venue'] ?? '',
      gmap: json['gmap'] ?? '',
      startDate: DateTime.parse(json['start_date'] ?? ''),
      endDate: DateTime.parse(json['end_date'] ?? ''),
      visibility: json['visibility'] ?? '',
      createdOn: json['created_on'] ?? '',
      updatedOn: json['updated_on'] ?? '',
      gallery: json['gallery'] ?? [],
       previous: json['previous'] != null ? Previous.fromJson(json['previous']) : null,
      next: json['next'] != null ? Next.fromJson(json['next']) : null,
    );
  }
}


class Previous {
  final String id;

  Previous({
    required this.id,
  });

  factory Previous.fromJson(Map<String, dynamic> json) {
    return Previous(
      id: json['id'],
    );
  }
}

class Next {
  final String id;

  Next({
    required this.id,
  });

  factory Next.fromJson(Map<String, dynamic> json) {
    return Next(
      id: json['id'],
    );
  }
}
