import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_styles.dart';
import '../widgets/custom_wave_clipper.dart';
import '../routes/route_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptTerms = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Wave background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: CustomWaveClipper(),
              child: Container(
                height: 142,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFB74D), Color(0xFFFFB74D)],
                  ),
                ),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).size.height * 0.02, 24, 17),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Register",
                          style: AppStyles.headingStyle.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Make new account",
                          style: AppStyles.subHeading.copyWith(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        
                        // Username field
                        _buildInputField(
                          controller: _usernameController,
                          label: 'Username',
                          hintText: 'Enter username',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            if (value.length < 4) {
                              return 'Username must be at least 4 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Phone number field
                        _buildInputField(
                          controller: _phoneController,
                          label: 'Phone number',
                          hintText: 'Enter phone number',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            if (!RegExp(r'^\d{10,}').hasMatch(value)) {
                              return 'Phone number must be at least 10 digits';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Password field
                        _buildInputField(
                          controller: _passwordController,
                          label: 'Password',
                          hintText: 'Enter password',
                          obscureText: !_passwordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black38,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return 'Password must contain at least one uppercase letter';
                            }
                            if (!RegExp(r'[0-9]').hasMatch(value)) {
                              return 'Password must contain at least one number';
                            }
                            if (!RegExp(r'[!@#\$&*~_\-\^%\(\)\[\]\{\}:;,.<>?/|+=]').hasMatch(value)) {
                              return 'Password must contain at least one symbol';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Confirm Password field
                        _buildInputField(
                          controller: _confirmPasswordController,
                          label: 'Confirm Password',
                          hintText: 'Confirm your password',
                          obscureText: !_confirmPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black38,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _confirmPasswordVisible = !_confirmPasswordVisible),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Terms and conditions
                        Row(
                          children: [
                            Checkbox(
                              value: _acceptTerms,
                              onChanged: (value) {
                                setState(() {
                                  _acceptTerms = value ?? false;
                                });
                              },
                              visualDensity: VisualDensity.compact,
                              activeColor: AppStyles.greenBorder,
                            ),
                            const Text('I understand terms & policy'),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Register button
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            height: 50,
                            decoration: AppStyles.gradientButtonDecoration.copyWith(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate() && _acceptTerms) {
                                  // Show loading splash screen
                                  context.pushNamed(MyAppRouteConstants.phoneVerificationRouteName);
                                  
                                  // Simulate registration delay
                                  await Future.delayed(const Duration(seconds: 2));
                                  
                                  // Navigate to phone verification screen
                                  if (mounted) {
                                    context.pushNamed(MyAppRouteConstants.phoneVerificationRouteName);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Login link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have account? ', style: AppStyles.subHeading),
                            GestureDetector(
                              onTap: () => context.pushNamed(MyAppRouteConstants.loginRouteName),
                              child: const Text(
                                'Login now',
                                style: TextStyle(
                                  color: AppStyles.greenBorder,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Social login section
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('or login with'),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Social buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialButton(
                              onPressed: () {
                                // Handle Google login
                              },
                              icon: 'assets/google_icon.png',
                            ),
                            const SizedBox(width: 20),
                            _socialButton(
                              onPressed: () {
                                // Handle Facebook login
                              },
                              icon: 'assets/facebook.png',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Stack(
      children: [
        Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: AppStyles.greenBorder),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          left: 25,
          top: -11,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: AppStyles.backgroundColor,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFFFFB74D),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 16, color: Colors.black87),            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black38, fontSize: 16),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
              suffixIcon: suffixIcon,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _socialButton({
    required VoidCallback onPressed,
    required String icon,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          icon,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
