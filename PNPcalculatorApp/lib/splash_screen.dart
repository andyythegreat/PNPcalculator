import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  double _opacity = 0.0;
  bool _showIcon = false;
  late AnimationController _bgController;
  late Animation<Color?> _bgColor1;
  late Animation<Color?> _bgColor2;

  @override
  void initState() {
    super.initState();

    // Background Animation
    _bgController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _bgColor1 = ColorTween(
      begin: const Color(0xFF040A23),
      end: const Color(0xFF0C174C),
    ).animate(_bgController);

    _bgColor2 = ColorTween(
      begin: const Color(0xFF111923),
      end: const Color(0xFF3C62E4),
    ).animate(_bgController);

    // FADE
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // SWITCH
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _showIcon = true;
      });
    });

    // NAVIGATOR
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _bgColor1.value ?? const Color(0xFF07123C),
                  _bgColor2.value ?? const Color(0xFF3B64D8),
                ],
              ),
            ),
            child: Center(
              child: AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: _opacity,
                curve: Curves.easeIn,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 800),
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                      child: _showIcon
                          ? const Icon(Icons.calculate_rounded, key: ValueKey('icon'), color: Colors.white, size: 100)
                          : const Text(
                        'PNP PENSION',
                        key: ValueKey('text'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const LoadingDots(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _dotAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _dotAnimations = [
      Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1.3)).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeInOut)),
      ),
      Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1.3)).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.6, curve: Curves.easeInOut)),
      ),
      Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1.3)).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8, curve: Curves.easeInOut)),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(Animation<Offset> animation, Color color) {
    return SlideTransition(
      position: animation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _dot(_dotAnimations[0], Colors.white),
        _dot(_dotAnimations[1], Colors.white),
        _dot(_dotAnimations[2], Colors.white),
      ],
    );
  }
}

