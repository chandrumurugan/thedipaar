// class News {
//   final String id;
//   final String catId;
//   final String catName;
//   final String title;
//   final String description;
//   final String short;
//   final String img;
//   final String createdDate;

//   News({
//     required this.id,
//     required this.catId,
//     required this.catName,
//     required this.title,
//     required this.description,
//     required this.short,
//     required this.img,
//     required this.createdDate,
//   });

//   factory News.fromJson(Map<String, dynamic> json) {
//     return News(
//       id: json['id'] ?? '',
//       catId: json['cat_id'] ?? '',
//       catName: json['cat_name'] ?? '',
//       title: json['title'] ?? '',
//       description: json['description'] ?? '',
//       short: json['short'] ?? '',
//       img: json['img'] ?? '',
//       createdDate: json['created_date'] ?? '',
//     );
//   }
// }

class News {
  final String id;
  final String catId;
  final String catName;

  final String title;
  final String description;
  final String short;
  final String img;


  final String createdDate;

  final Previous? previous;
  final Next? next;

  News({
    required this.id,
    required this.catId,
    required this.catName,

    required this.title,
    required this.description,
    required this.short,
    required this.img,
    required this.createdDate,

    required this.previous,
    required this.next,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      catId: json['cat_id'],
      catName: json['cat_name'],

      title: json['title'],
      description: json['description'],
      short: json['short'],
      img: json['img'],
      createdDate: json['created_date'],
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

