class DummyModel {
  List<Dummies>? dummies;
  String? error;

  DummyModel({this.dummies});

  DummyModel.withError(String errorMessage){
    error = errorMessage;
  }

  DummyModel.fromJson(Map<String, dynamic> json) {
    if (json['dummies'] != null) {
      dummies = <Dummies>[];
      json['dummies'].forEach((v) {
        dummies!.add(new Dummies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dummies != null) {
      data['dummies'] = this.dummies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dummies {
  int? userId;
  int? id;
  String? title;
  String? body;

  Dummies({this.userId, this.id, this.title, this.body});

  Dummies.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}