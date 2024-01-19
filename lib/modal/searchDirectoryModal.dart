class SearchDirectory {
  final String cat_id;
  final String img;

  SearchDirectory({required this.cat_id, required this.img});
  factory SearchDirectory.fromJson(Map<String, dynamic> json) {
    return SearchDirectory(cat_id: json['cat_id'], img: json['img']);
  }
}
