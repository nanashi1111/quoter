class SideMenuModel {
  String? icon;
  String? title;

  SideMenuModel({this.icon, this.title});

  SideMenuModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    return data;
  }
}