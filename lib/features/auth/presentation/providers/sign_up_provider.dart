import 'package:doc_app/core/extension/navigation.dart';
import 'package:doc_app/core/functions/show_error.dart';
import 'package:flutter/material.dart';
import '../../../../core/helper/app_regex.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/routes/routes.dart';
import '../../data/models/sign_up_request_body.dart';
import '../../data/models/sign_up_response.dart';
import '../../data/repos/sign_up_repo.dart';

class SignupProvider extends ChangeNotifier {
  final SignupRepo _signupRepo;

  SignupProvider(this._signupRepo) {
    _initControllers();
  }

  // Text controllers
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;

  late GlobalKey<FormState> formKey;

  // State
  bool _isLoading = false;
  String? _errorMessage;
  SignupResponse? _signupResponse;
  int _selectedGender = 0; // 0 = not selected, 1 = male, 2 = female

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
  SignupResponse? get signupResponse => _signupResponse;
  bool get hasLowercase => _hasLowercase;
  bool get hasUppercase => _hasUppercase;
  bool get hasSpecialCharacters => _hasSpecialCharacters;
  bool get hasNumber => _hasNumber;
  bool get hasMinLength => _hasMinLength;
  bool get isObscureText => _isObscureText;
  int get selectedGender => _selectedGender;

  void _initControllers() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    formKey = GlobalKey<FormState>();

    // Setup password validation listener
    passwordController.addListener(_validatePassword);

    // Initialize gender to not selected by default
    _selectedGender = 0;
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
  Future<void> signup(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final signupRequestBody = SignupRequestBody(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      gender: _selectedGender,
      passwordConfirmation: passwordConfirmationController.text,
      phone: phoneController.text.trim(),
      password: passwordController.text,
    );

    final response = await _signupRepo.signup(signupRequestBody);

    if (!context.mounted) return;

    if (response is Success<SignupResponse>) {
      _signupResponse = response.data;
      context.pushReplacementNamed(Routes.homeView);
    } else if (response is Failure<SignupResponse>) {
      _errorMessage =
          response.apiErrorModel.message ??
          'Oops! Something went wrong. Please try again.';
      showError(_errorMessage!);
    }

    _isLoading = false;
    notifyListeners();
  }

  // Clear state
  void selectGender(int gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  void clear() {
    _isLoading = false;
    _errorMessage = null;
    _signupResponse = null;
    _selectedGender = 0; // Reset to unselected
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
