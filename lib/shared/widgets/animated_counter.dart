import 'package:flutter/material.dart';

/// Animates an integer value change with a smooth roll-up effect.
///
/// When [value] changes, the displayed number smoothly transitions
/// from the old value to the new one over [duration].
class AnimatedCounter extends StatelessWidget {
  final int value;
  final TextStyle? style;
  final Duration duration;
  final Curve curve;
  final String? prefix;
  final String? suffix;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: duration,
      curve: curve,
      builder: (context, animatedValue, child) {
        return Text(
          '${prefix ?? ''}$animatedValue${suffix ?? ''}',
          style: style ?? Theme.of(context).textTheme.headlineMedium,
        );
      },
    );
  }
}
