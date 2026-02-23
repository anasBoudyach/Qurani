import 'package:flutter/material.dart';

/// Animates children in a grid with staggered fade + scale + slide-up.
///
/// Each child enters with 50ms delay after the previous one.
/// Uses [AutomaticKeepAliveClientMixin] so animations don't re-trigger
/// when switching tabs in the bottom navigation.
class StaggeredAnimationGrid extends StatefulWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final Duration itemDuration;
  final Duration staggerDelay;

  const StaggeredAnimationGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 4,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.childAspectRatio = 0.85,
    this.itemDuration = const Duration(milliseconds: 400),
    this.staggerDelay = const Duration(milliseconds: 50),
  });

  @override
  State<StaggeredAnimationGrid> createState() => _StaggeredAnimationGridState();
}

class _StaggeredAnimationGridState extends State<StaggeredAnimationGrid>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<Offset>> _slideAnimations;
  bool _hasAnimated = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    if (!_hasAnimated) {
      _startAnimations();
    }
  }

  void _initAnimations() {
    _controllers = List.generate(
      widget.children.length,
      (i) => AnimationController(
        vsync: this,
        duration: widget.itemDuration,
      ),
    );

    _fadeAnimations = _controllers.map((c) {
      return CurvedAnimation(parent: c, curve: Curves.easeOut)
          .drive(Tween<double>(begin: 0.0, end: 1.0));
    }).toList();

    _scaleAnimations = _controllers.map((c) {
      return CurvedAnimation(parent: c, curve: Curves.easeOutCubic)
          .drive(Tween<double>(begin: 0.8, end: 1.0));
    }).toList();

    _slideAnimations = _controllers.map((c) {
      return CurvedAnimation(parent: c, curve: Curves.easeOutCubic)
          .drive(Tween<Offset>(
        begin: const Offset(0, 0.15),
        end: Offset.zero,
      ));
    }).toList();
  }

  Future<void> _startAnimations() async {
    _hasAnimated = true;
    for (int i = 0; i < _controllers.length; i++) {
      if (!mounted) return;
      Future.delayed(widget.staggerDelay * i, () {
        if (mounted && i < _controllers.length) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void didUpdateWidget(StaggeredAnimationGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length) {
      for (final c in _controllers) {
        c.dispose();
      }
      _initAnimations();
      // Don't re-animate on widget update — just show them
      for (final c in _controllers) {
        c.value = 1.0;
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return GridView.count(
      crossAxisCount: widget.crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: widget.mainAxisSpacing,
      crossAxisSpacing: widget.crossAxisSpacing,
      childAspectRatio: widget.childAspectRatio,
      children: List.generate(widget.children.length, (i) {
        return AnimatedBuilder(
          animation: _controllers[i],
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimations[i],
              child: SlideTransition(
                position: _slideAnimations[i],
                child: ScaleTransition(
                  scale: _scaleAnimations[i],
                  child: child,
                ),
              ),
            );
          },
          child: widget.children[i],
        );
      }),
    );
  }
}
