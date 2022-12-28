class GIFModel {
  int? fileSizeBytes;
  String? url;
  String? error;
  GIFModel({this.fileSizeBytes, this.url});

  GIFModel.withError(String errorMessage){
    error = errorMessage;
  }

  GIFModel.fromJson(Map<String, dynamic> json) {
    fileSizeBytes = json['fileSizeBytes'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileSizeBytes'] = this.fileSizeBytes;
    data['url'] = this.url;
    return data;
  }
}