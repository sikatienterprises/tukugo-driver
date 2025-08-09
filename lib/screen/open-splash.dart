import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/route_constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OpenSplashScreen(),
    );
  }
}

class OpenSplashScreen extends StatefulWidget {
  const OpenSplashScreen({super.key});

  @override
  State<OpenSplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<OpenSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late Animation<Offset> _entryAnimation;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  late AnimationController _expandController;
  late Animation<double> _scaleAnimation;

  late AnimationController _textController;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _textBounceAnimation;

  late AnimationController _backgroundController;
  late Animation<double> _backgroundAnimation;

  late AnimationController _twinkleController;
  late Animation<double> _twinkleScale;

  bool _showCircle = false;
  bool _showBlob = false;
  bool _showText = false;
  bool _showBackground = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    // Entry animation - circle slides in from left
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _entryAnimation = Tween<Offset>(
      begin: const Offset(-2.0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    ));

    // Shake animation
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));

    // Expand animation
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 30.0,
    ).animate(CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeOut,
    ));

    // Text bounce animation - from left to right, then bounce back to center
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.0, 0.1, curve: Curves.easeIn),
    ));

    _textBounceAnimation = TweenSequence<Offset>([
      // Move from left edge to right edge
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(-1.5, 0), // Start from left edge
          end: const Offset(1.5, 0), // Go to right edge
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      // Bounce back to center with elastic effect
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(1.5, 0), // From right edge
          end: Offset.zero, // To center
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
    ]).animate(_textController);

    // Background animation
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeOut,
    ));

    // Twinkle animation for blob
    _twinkleController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 2400), // slightly longer for extra twinkle
    );
    _twinkleScale = TweenSequence([
      // First twinkle
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.3)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.3, end: 0.8)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
      // Second twinkle
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.8, end: 1.3)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.3, end: 0.8)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
      // Final spread
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.8, end: 30.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20,
      ),
    ]).animate(_twinkleController);
  }

  Future<void> _startAnimationSequence() async {
    // Wait 0.5 second before starting
    await Future.delayed(const Duration(milliseconds: 500));

    // 1. Show blob directly (skip circle entry)
    setState(() {
      _showCircle = false; // Not used
      _showBlob = true;
      _showText = true; // Show text at the same time as blob twinkle
    });
    // Start twinkle and text bounce together
    await Future.wait([
      _twinkleController.forward(),
      _textController.forward(),
    ]);
    await Future.delayed(
        const Duration(milliseconds: 300)); // Optional: slight pause for effect

    // 2. Expand blob to fill background
    setState(() => _showBackground = true);
    _backgroundController.forward();
    _expandController.forward();

    // Navigate to splash as soon as the blob starts expanding (no wait)
    if (mounted) {
      GoRouter.of(context).goNamed(MyAppRouteConstants.loginRouteName);
    }
  }

  void _restartAnimation() {
    // Reset all controllers and states
    _entryController.reset();
    _shakeController.reset();
    _expandController.reset();
    _textController.reset();
    _backgroundController.reset();
    _twinkleController.reset();

    setState(() {
      _showCircle = false;
      _showBlob = false;
      _showText = false;
      _showBackground = false;
    });

    // Start the sequence again
    _startAnimationSequence();
  }

  @override
  void dispose() {
    _entryController.dispose();
    _shakeController.dispose();
    _expandController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    _twinkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: _restartAnimation,
        child: Stack(
          children: [
            // Background gradient
            if (_showBackground)
              AnimatedBuilder(
                animation: _backgroundAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _backgroundAnimation.value,
                    child: Transform.scale(
                      scale: _backgroundAnimation.value,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 124, 124, 192),
                              Color(0xFFEAEAEA)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

            // Blob with twinkle effect (skip circle entry)
            if (_showBlob)
              Center(
                child: AnimatedBuilder(
                  animation: _twinkleController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _twinkleScale.value,
                      child: const BlobShape(),
                    );
                  },
                ),
              ),

            // Text with bounce animation
            if (_showText)
              Center(
                child: AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _textBounceAnimation,
                      child: Opacity(
                        opacity: _textOpacityAnimation.value,
                        child: Text(
                          "Tuku Go",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 52,
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            // Restart button (commented out)
            // Positioned(
            //   bottom: 50,
            //   left: 0,
            //   right: 0,
            //   child: Center(
            //     child: ElevatedButton(
            //       onPressed: _restartAnimation,
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.white.withOpacity(0.2),
            //         foregroundColor: Colors.black,
            //         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(25),
            //           side: BorderSide(color: Colors.black.withOpacity(0.3)),
            //         ),
            //       ),
            //       child: const Text(
            //         "Restart Animation",
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class CircleShape extends StatelessWidget {
  const CircleShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 124, 124, 192), Color(0xFFEAEAEA)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class BlobShape extends StatelessWidget {
  const BlobShape({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BlobClipper(),
      child: Container(
        width: 120,
        height: 120,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 124, 124, 192), Color(0xFFEAEAEA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}

class BlobClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;

    // Create a more organic blob shape
    path.moveTo(width * 0.5, 0);
    path.cubicTo(width * 0.9, 0, width, height * 0.2, width, height * 0.5);
    path.cubicTo(width, height * 0.8, width * 0.8, height, width * 0.5, height);
    path.cubicTo(width * 0.2, height, 0, height * 0.8, 0, height * 0.5);
    path.cubicTo(0, height * 0.2, width * 0.1, 0, width * 0.5, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
