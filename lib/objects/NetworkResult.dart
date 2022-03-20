

class NetworkResult {

  List<dynamic>? _objects;
  dynamic? _object;
  int _networkResult = 404;

  NetworkResult(List<dynamic>? objects, dynamic? object,int networkResult) {
    _networkResult = networkResult;
    _objects = objects;
    _object = object;
  }

  List<dynamic>? getObjects() {
    return _objects;
  }

  dynamic? getObject() {
    return _object;
  }

  int getNetworkResult() {
    return _networkResult;
  }

}