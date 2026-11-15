import 'dart:math';
import 'package:faith/colorapp.dart';
import 'package:faith/dhikr_feature/presentation/provider/dhikrprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Progressdhikrwid extends StatefulWidget {
  const Progressdhikrwid({super.key});

  @override
  State<Progressdhikrwid> createState() => _ProgressdhikrwidState();
}

class _ProgressdhikrwidState extends State<Progressdhikrwid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Offset> _starPositions = const [
    Offset(-0.9, -0.7),
    Offset(0.9, -0.6),
    Offset(-1.0, 0.1),
    Offset(1.0, 0.15),
    Offset(-0.6, 0.9),
    Offset(0.6, 0.9),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (!_controller.isAnimating) {
      _controller.forward(from: 0).then((_) {
        if (!mounted) return;
        _controller.reset(); // FIX: agli baar dobara chale
        context.read<Dhikrprovider>().finishAnimation();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Dhikrprovider>();

    if (provider.showCompletionAnimation && !_controller.isAnimating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _startAnimation();
      });
    }

    // Responsive size: width aur height dono ka khayal
    final screen = MediaQuery.sizeOf(context);
    final double size = min(screen.width * 0.6, min(screen.height * 0.35, 280));

    // Sab kuch size ke hisab se scale hota hai
    final double outerStroke = size * 0.06;
    final double innerStroke = size * 0.04;
    final double innerSize = size * 0.8;
    final double textBox = size * 0.55;
    final double starSize = size * 0.17;

    final Color progressColor = provider.counter >= provider.target
        ? AppColors.gold
        : AppColors.emeraldGreen;

    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // OUTER PROGRESS
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                strokeWidth: outerStroke,
                value: provider.progress,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              ),
            ),

            // INNER PROGRESS
            SizedBox(
              width: innerSize,
              height: innerSize,
              child: CircularProgressIndicator(
                strokeWidth: innerStroke,
                value: provider.progress,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              ),
            ),

            // CENTER TEXT (ring ke andar hi rahega)
            SizedBox(
              width: textBox,
              height: textBox,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      provider.currentDhikr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: progressColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${provider.counter}",
                      style: TextStyle(
                        color: progressColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      "/${provider.target}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // STAR ANIMATION
            if (provider.showCompletionAnimation)
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final double t = _controller.value;
                      final double move = Curves.easeOutCubic.transform(t);
                      final double fade = 1 - Curves.easeIn.transform(t);
                      final double scale = t < 0.2 ? t / 0.2 : fade;

                      return Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: List.generate(6, (index) {
                          final Offset dir = _starPositions[index];
                          final double distance = size * 0.53 * move;

                          return Transform.translate(
                            offset: Offset(dir.dx * distance, dir.dy * distance),
                            child: Transform.rotate(
                              angle: t * 2 * pi * (index.isEven ? 1 : -1),
                              child: Transform.scale(
                                scale: scale.clamp(0.0, 1.2),
                                child: Icon(
                                  Icons.star,
                                  color: AppColors.gold,
                                  size: starSize,
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}