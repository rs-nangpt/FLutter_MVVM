import 'package:flutter/cupertino.dart';
import 'package:mvvmflutter/data/repositories/user_repository.dart';
import 'package:mvvmflutter/data/response/api_response.dart';
import 'package:mvvmflutter/data/response/login_response.dart';

class LoginViewModel with ChangeNotifier {
  BaseResponse<LoginResponse> vmBaseResponse =
  BaseResponse.initial('Empty data');
  bool? isShowLoading ;

   setLoading(bool loadingState){
    isShowLoading = loadingState;
   }

  /// check valid value
  bool isValidate(String? email, String? password) {
    if (email?.isNotEmpty == true && email?.isNotEmpty == true)
      return true;
    else
      return false;
  }


  /// call API Login
  Future<void> login(String email, String password) async {
    vmBaseResponse = BaseResponse.loading('Fetching artist data');
    notifyListeners();
    try {
      LoginResponse loginResponse = await UserRepository().userLogin(
          email, password);
      vmBaseResponse = BaseResponse.completed(loginResponse);
    } catch (e) {
      vmBaseResponse = BaseResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}
