import 'package:http/http.dart' as http;

abstract class NetworkRequests {
  static String _baseURLAPI = 'http://10.0.2.2:8000/api/';

  static getResult(String arg) async {
    var result = await http.get(Uri.parse(_baseURLAPI + arg));
    print(_baseURLAPI + arg);
    return result;
  }

  static postResult(String arg, Map<String,String?> noteJSON) async {
    var result = await http.post(Uri.parse(_baseURLAPI + arg), body: noteJSON);
    return result;
  }
  
}