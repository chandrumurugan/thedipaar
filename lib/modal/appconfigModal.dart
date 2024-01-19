class Appconfig {
  final String share_baseurl;
  final String aboutus_url;
  final String contactus_url;

  Appconfig(
      {required this.share_baseurl,
      required this.aboutus_url,
      required this.contactus_url});

  factory Appconfig.fromJson(Map<String, dynamic> json) {
    return Appconfig(
        share_baseurl: json['share_baseurl'],
        aboutus_url: json['aboutus_url'],
        contactus_url: json['contactus_url']);
  }
}
