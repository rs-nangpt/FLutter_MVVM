import 'package:mvvmflutter/data/network/api_service.dart';
import 'package:mvvmflutter/data/response/login_response.dart';

class UserRepository {
  APIService _apiService = APIService();

  Future<LoginResponse> userLogin(String email, String password) async {
    dynamic response = await _apiService.userLogin(email, password);
    LoginResponse loginResponse =
        LoginResponse.fromJson(Map<String, dynamic>.from(response));
    return loginResponse;
  }
}
