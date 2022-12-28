import '../models/dummy_model.dart';
import '../models/gif_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<DummyModel> fetchDummyList() {
    return _provider.fetchDummyList();
  }

  Future<GIFModel> fetchGIF(){
    return _provider.fetchGIF();
  }

}

class NetworkError extends Error {}