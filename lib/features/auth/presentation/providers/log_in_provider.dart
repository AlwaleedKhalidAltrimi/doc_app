import 'package:doc_app/core/extension/navigation.dart';
import 'package:doc_app/core/functions/show_error.dart';
import 'package:flutter/material.dart';
import '../../../../core/helper/app_regex.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/routes/routes.dart';
import '../../data/models/log_in_request_body.dart';
import '../../data/models/log_in_response.dart';
import '../../data/repos/log_in_repo.dart';

class LoginProvider extends ChangeNotifier {
  final LoginRepo _loginRepo;

  LoginProvider(this._loginRepo) {
    _initControllers();
  }

  // Text controllers
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late GlobalKey<FormState> formKey;

  // State
  bool _isLoading = false;
  String? _errorMessage;
  LoginResponse? _loginResponse;

  // Password validation flags
  bool _hasLowercase = false;
  bool _hasUppercase = false;
  bool _hasSpecialCharacters = false;
  bool _hasNumber = false;
  bool _hasMinLength = false;
  bool _isObscureText = true;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LoginResponse? get loginResponse => _loginResponse;
  bool get hasLowercase => _hasLowercase;
  bool get hasUppercase => _hasUppercase;
  bool get hasSpecialCharacters => _hasSpecialCharacters;
  bool get hasNumber => _hasNumber;
  bool get hasMinLength => _hasMinLength;
  bool get isObscureText => _isObscureText;

  void _initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();

    // Setup password validation listener
    passwordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final text = passwordController.text;
    _hasLowercase = AppRegex.hasLowerCase(text);
    _hasUppercase = AppRegex.hasUpperCase(text);
    _hasSpecialCharacters = AppRegex.hasSpecialCharacter(text);
    _hasNumber = AppRegex.hasNumber(text);
    _hasMinLength = AppRegex.hasMinLength(text);
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isObscureText = !_isObscureText;
    notifyListeners();
  }

  // Handle login request
  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final loginRequestBody = LoginRequestBody(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    final response = await _loginRepo.login(loginRequestBody);

    if (!context.mounted) return;

    if (response is Success<LoginResponse>) {
      _loginResponse = response.data;
      context.pushReplacementNamed(Routes.homeView);
    } else if (response is Failure<LoginResponse>) {
      _errorMessage =
          response.apiErrorModel.message ??
          'Oops! Something went wrong. Please try again.';
      showError(_errorMessage!);
    }

    _isLoading = false;
    notifyListeners();
  }

  // Clear state
  void clear() {
    _isLoading = false;
    _errorMessage = null;
    _loginResponse = null;
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
