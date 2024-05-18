// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class FoodList {
  List<Food>? food;

  FoodList({this.food});

  FoodList.fromJson(Map<String, dynamic> json) {
    if (json['food'] != null) {
      food = <Food>[];
      json['food'].forEach((v) {
        food!.add(new Food.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.food != null) {
      data['food'] = this.food!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Food? findFoodById(int id) {
    for (Food item in food!) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }
}

class Food {
  int? id;
  String? name;
  String? description;
  double? price;

  Food({this.id, this.name, this.description, this.price});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    return data;
  }
}
