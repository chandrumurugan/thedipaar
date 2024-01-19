class NewsCategory {

final String categoryName;


  // final String categoryName;

  NewsCategory({required this.categoryName});

  factory NewsCategory.fromJson(Map<String, dynamic> json) {
    return NewsCategory(
      categoryName: json['cat_name'],
    );
  }

}