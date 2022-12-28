import 'package:dio/dio.dart';
import 'package:pet_perfect_assignment/models/dummy_model.dart';
import 'package:pet_perfect_assignment/models/gif_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _dummies_url = 'http://jsonplaceholder.typicode.com/posts';
  final String _gif_url = 'https://random.dog/woof.json';

  Future<DummyModel> fetchDummyList() async {
    try {
      Response response = await _dio.get(_dummies_url);
      Map<String, dynamic> response2 = {'dummies': response.data};
      return DummyModel.fromJson(response2);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DummyModel.withError("Data not found / Connection issue");
    }
  }

  Future<GIFModel> fetchGIF() async {
    try{
      Response response = await _dio.get(_gif_url);
      print(response.data);
      return GIFModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GIFModel.withError("Data not found / Connection issue");
    }
  }
}