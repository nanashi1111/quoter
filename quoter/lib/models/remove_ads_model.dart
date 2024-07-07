class RemoveAdsModel {
  String? title;
  int? price;

  RemoveAdsModel({this.title, this.price});

  RemoveAdsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }
}