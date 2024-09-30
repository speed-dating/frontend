class CreateDatingModel {
  String? title;
  String? description;
  double? price;
  List<String>? imagePaths;
  int? maleCapacity;
  int? femaleCapacity;
  String? startDate;
  List<String>? tags;

  CreateDatingModel({
    this.title,
    this.price,
    this.imagePaths,
    this.maleCapacity,
    this.femaleCapacity,
    this.startDate,
    this.description,
    this.tags,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'price': price,
        'imagePaths': imagePaths,
        'maleCapacity': maleCapacity,
        'femaleCapacity': femaleCapacity,
        'startDate': startDate,
        'tags': tags,
      };

  factory CreateDatingModel.fromJson(Map<String, dynamic> json) {
    return CreateDatingModel(
      title: json['title'],
      description: json['description'],
      price: json['price'],
      imagePaths: List<String>.from(json['imagePaths'] ?? []),
      maleCapacity: json['maleCapacity'],
      femaleCapacity: json['femaleCapacity'],
      startDate: json['startDate'],
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}
