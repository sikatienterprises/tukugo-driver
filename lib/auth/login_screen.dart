import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_styles.dart';
import '../widgets/custom_wave_clipper.dart';
import '../routes/route_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _passwordVisible = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      // Show loading splash screen
       context.pushNamed(MyAppRouteConstants.loginSplashScreen);

      // Simulate login delay
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to home screen and remove all previous routes
      if (mounted) {
        context.goNamed(MyAppRouteConstants.homeRouteName);
      }
    }
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
                  padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).size.height * 0.02, 24, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 25),
                        Text(
                          "Login",
                          style: AppStyles.headingStyle.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Welcome Back",
                          style: AppStyles.subHeading.copyWith(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        
                        // Login ID field
                        _buildInputField(
                          controller: _usernameController,
                          label: 'Login Id',
                          hintText: '8143224221',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter login id';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                      
                        // Password field
                        _buildInputField(
                          controller: _passwordController,
                          label: 'Password',
                          hintText: 'Password',
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
                            return null;
                          },
                        ),
                        
                        // Remember me and Forgot Password
                        Row(
                          children: [
                            Switch(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value;
                                });
                              },
                              activeColor: AppStyles.greenBorder,
                            ),
                            const Text("Remember me"),
                            const Spacer(),
                            GestureDetector(                              onTap: () {
                                context.pushNamed(MyAppRouteConstants.setPasswordRouteName);
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: AppStyles.greenBorder,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 15),
                        
                        // Login button
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            height: 50,
                            decoration: AppStyles.gradientButtonDecoration.copyWith(
                              borderRadius: BorderRadius.circular(25),
                            ),                            child: ElevatedButton(                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Show loading splash screen
                                   context.pushNamed(MyAppRouteConstants.loginSplashScreen);
                                  
                                  // Simulate login delay
                                  await Future.delayed(const Duration(seconds: 2));
                                  
                                  // Navigate to home screen and remove all previous routes
                                  if (mounted) {
                                    context.goNamed(MyAppRouteConstants.homeRouteName);
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
                                "Login",
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
                        
                        // Register now link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("new user? ", style: AppStyles.subHeading),
                            GestureDetector(                              onTap: () {
                                context.pushNamed(MyAppRouteConstants.registerRouteName);
                              },
                              child: const Text(
                                "register now",
                                style: TextStyle(
                                  color: AppStyles.greenBorder,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 10),
                        // Social login section
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text("or login with", style: TextStyle(fontSize: 12)),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Social login buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialLoginButton(
                              'assets/google_icon.png',
                              () {
                                // Handle Google login
                              },
                            ),
                            const SizedBox(width: 20),
                            _socialLoginButton(
                              'assets/facebook.png',
                              () {
                                // Handle Facebook login
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black38, fontSize: 16),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,              contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
              suffixIcon: suffixIcon,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _socialLoginButton(String iconPath, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          iconPath,
          height: 30,
          width: 30,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}