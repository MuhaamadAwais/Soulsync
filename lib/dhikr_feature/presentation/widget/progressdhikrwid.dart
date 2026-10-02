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

  final List<Offset> _starPositions = [
    const Offset(-0.9, -0.7),
    const Offset(0.9, -0.6),
    const Offset(-1.0, 0.1),
    const Offset(1.0, 0.15),
    const Offset(-0.6, 0.9),
    const Offset(0.6, 0.9),
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
        if (mounted) {
          context.read<Dhikrprovider>().finishAnimation();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Dhikrprovider>(context);

    if (provider.showCompletionAnimation &&
        !_controller.isAnimating &&
        _controller.value == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _startAnimation();
        }
      });
    }

    final double width = MediaQuery.of(context).size.width;

    final Color progressColor =
        provider.counter >= provider.target
            ? AppColors.gold
            : AppColors.emeraldGreen;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // =========================
          // OUTER PROGRESS
          // =========================
          SizedBox(
            width: width * 0.6,
            height: width * 0.6,
            child: CircularProgressIndicator(
              strokeWidth: 15,
              value: provider.progress,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(
                progressColor,
              ),
            ),
          ),

          // =========================
          // INNER PROGRESS
          // =========================
          SizedBox(
            width: width * 0.48,
            height: width * 0.48,
            child: CircularProgressIndicator(
              strokeWidth: 10,
              value: provider.progress,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(
                progressColor,
              ),
            ),
          ),

          // =========================
          // CENTER TEXT
          // =========================
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(height: 10),

              Text(
                provider.currentDhikr,
                style: TextStyle(
                  color: progressColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 5),

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

          // =========================
          // ⭐ STAR ANIMATION
          // =========================
          if (provider.showCompletionAnimation)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: List.generate(
                        6,
                        (index) {
                          final double progress =
                              Curves.easeOutCubic.transform(
                            _controller.value,
                          );

                          final double fade =
                              1 - Curves.easeIn.transform(
                                _controller.value,
                              );

                          final Offset direction =
                              _starPositions[index];

                          final double distance =
                              width * 0.32 * progress;

                          final double x =
                              direction.dx * distance;

                          final double y =
                              direction.dy * distance;

                          final double scale =
                              _controller.value < 0.2
                                  ? _controller.value / 0.2
                                  : fade;

                          return Transform.translate(
                            offset: Offset(x, y),
                            child: Transform.rotate(
                              angle:
                                  _controller.value *
                                  2 *
                                  pi *
                                  (index.isEven ? 1 : -1),
                              child: Transform.scale(
                                scale: scale.clamp(0.0, 1.2),
                                child: const Icon(
                                  Icons.star,
                                  color: AppColors.gold,
                                  size: 38,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}