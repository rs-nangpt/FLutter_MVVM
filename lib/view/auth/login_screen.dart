import 'package:flutter/material.dart';
import 'package:mvvmflutter/data/response/api_response.dart';
import 'package:mvvmflutter/data/response/login_response.dart';
import 'package:mvvmflutter/utils/common_utils.dart';
import 'package:mvvmflutter/view/auth/login_viewmodel.dart';
import 'package:mvvmflutter/view/common/form_input_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _editEmailController = TextEditingController();
  final TextEditingController _editPasswordController = TextEditingController();
  late LoginViewModel loginViewModel;

  @override
  void dispose() {
    _editEmailController.dispose();
    _editPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _editEmailController.text = "eve.holt@reqres.in";
    _editPasswordController.text = "cityslicka";
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loginViewModel = Provider.of<LoginViewModel>(context);
    BaseResponse apiResponse = loginViewModel.vmBaseResponse;
    checkLoginStatusWidget(context, apiResponse, loginViewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: 500,
        height: 1000,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/bg_login.jpeg"),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loginForm(loginViewModel),
              Visibility(
                  visible: loginViewModel.isShowLoading == true,
                  child: Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
      ),
    );
  }

  void checkLoginStatusWidget(
    BuildContext context,
    BaseResponse apiResponse,
    LoginViewModel loginViewModel,
  ) {
    LoginResponse? loginResponse = apiResponse.data as LoginResponse?;
    switch (apiResponse.status) {
      case Status.LOADING:
        loginViewModel.isShowLoading = true;
        break;
      case Status.COMPLETED:
        loginViewModel.isShowLoading = false;
        if (loginResponse?.token?.isNotEmpty == true) {
          CommonUtils().showToast("LOGIN SUCCESS");
        } else {
          CommonUtils().showToast("LOGIN FAIL  ${loginResponse?.error}");
        }
        break;
      case Status.ERROR:
        loginViewModel.isShowLoading = false;
        CommonUtils().showToast("LOGIN FAIL  ${apiResponse.message}");
        break;
      case Status.INITIAL:
        loginViewModel.isShowLoading = false;
        break;
    }
  }

  Widget loginForm(LoginViewModel loginViewModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FormInputField(
            label: 'Email',
            inputWidget: TextFormField(
              controller: _editEmailController,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            requiredType: RequiredType.none,
          ),
          FormInputField(
            label: 'Password',
            inputWidget: TextFormField(
              controller: _editPasswordController,
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            requiredType: RequiredType.none,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                submitLogin(loginViewModel);
              },
              child: Text("Login"),
            ),
          )
        ],
      ),
    );
  }

  void submitLogin(LoginViewModel loginViewModel) {
    if (loginViewModel.isValidate(
        _editEmailController.text, _editPasswordController.text)) {
      loginViewModel.login(
          _editEmailController.text, _editPasswordController.text);
    } else {
      CommonUtils().showToast("Email/Password is invalid");
    }
  }
}
