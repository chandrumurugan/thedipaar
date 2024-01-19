class DirectoryList {
  final String companyId;
  final String companyName;

  DirectoryList({required this.companyId, required this.companyName});

  factory DirectoryList.fromJson(Map<String, dynamic> json) {
    return DirectoryList(
      companyId: json['id'],
      companyName: json['name'],
    );
  }
}