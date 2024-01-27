class CatModel {
  final String url, id;

  const CatModel({required this.id, required this.url});

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'],
      url: json['url'],
    );
  }
}
