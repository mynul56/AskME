import 'package:get/get.dart';

class UserProvider extends GetConnect {
  Future<Response<dynamic>> getUser(int id) {
    return get<dynamic>('https://jsonplaceholder.typicode.com/users/$id');
  }
}
