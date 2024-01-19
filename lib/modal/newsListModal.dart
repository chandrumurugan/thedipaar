class NewsListModal {
  final String id;
  final String cat_name;
  final String sub_cat_name;
  final String img;
  final String title;
  final String meta_desc;
  final String created_date;
  final String shorts;

  NewsListModal( 
      {required this.id,
      required this.cat_name,
      required this.sub_cat_name,
      required this.img,
      required this.title,
      required this.meta_desc,
      required this.created_date,required this.shorts,});

  factory NewsListModal.fromJson(Map<String, dynamic> json) {
    return NewsListModal(
        id: json['id'] ?? '',
        cat_name: json['cat_name'] ?? '',
        sub_cat_name: json['sub_cat_name'] ?? '',
        img: json['img'] ?? '',
        title: json['title'] ?? '',
        meta_desc: json['meta_desc'] ?? '',
        created_date: json['created_date'] ?? '', shorts:json['short'] ?? '' );

  }
}
