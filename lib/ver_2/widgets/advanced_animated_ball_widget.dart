// widgets/advanced_animated_ball_widget.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/constants/app_constants.dart';
import 'package:qlutter/ver_2/models/animated_ball.dart';
import 'package:qlutter/ver_2/models/coordinates.dart';
import 'package:qlutter/ver_2/models/item.dart';

class AdvancedAnimatedBallWidget extends StatefulWidget {
  const AdvancedAnimatedBallWidget({
    required this.animatedBall,
    required this.elementSize,
    super.key,
    this.onAnimationComplete,
  });
  final AnimatedBall animatedBall;
  final double elementSize;
  final VoidCallback? onAnimationComplete;

  @override
  State<AdvancedAnimatedBallWidget> createState() =>
      _AdvancedAnimatedBallWidgetState();
}

class _AdvancedAnimatedBallWidgetState extends State<AdvancedAnimatedBallWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _squashXAnimation;
  late Animation<double> _squashYAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animatedBall.isCaptured
          ? AppConstants.ballCaptureDuration
          : AppConstants.ballMoveDuration,
      vsync: this,
    );

    _setupAnimations();
    _startAnimation();
  }

  @override
  void didUpdateWidget(AdvancedAnimatedBallWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.animatedBall != widget.animatedBall) {
      _controller.reset();
      _setupAnimations();
      _startAnimation();
    }
  }

  void _setupAnimations() {
    final ball = widget.animatedBall;

    if (ball.isCaptured) {
      // Анимация захвата
      _setupCaptureAnimations();
    } else if (ball.isMoving && ball.targetPosition != null) {
      // Анимация перемещения с продвинутой деформацией
      _setupMoveAnimations(ball);
    } else {
      // Статичное положение
      _setupStaticAnimations();
    }
  }

  void _setupCaptureAnimations() {
    _scaleAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AppConstants.ballCaptureCurve,
      ),
    );
    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AppConstants.ballCaptureCurve,
      ),
    );
    _positionAnimation = const AlwaysStoppedAnimation(Offset.zero);
    _squashXAnimation = const AlwaysStoppedAnimation(1);
    _squashYAnimation = const AlwaysStoppedAnimation(1);
    _bounceAnimation = const AlwaysStoppedAnimation(0);
  }

  void _setupMoveAnimations(AnimatedBall ball) {
    final dx = (ball.targetPosition!.x - ball.currentPosition.x).toDouble();
    final dy = (ball.targetPosition!.y - ball.currentPosition.y).toDouble();

    _positionAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(dx, dy))
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: AppConstants.ballMoveCurve,
          ),
        );

    // Сложная анимация деформации с "отскоком"
    final distance = max(dx.abs(), dy.abs());
    final isLongMove = distance > 1;

    switch (ball.moveDirection) {
      case Direction.up:
      case Direction.down:
        _squashXAnimation = TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 1, end: 0.6), weight: 0.3),
          TweenSequenceItem(tween: Tween(begin: 0.6, end: 0.8), weight: 0.4),
          TweenSequenceItem(tween: Tween(begin: 0.8, end: 1), weight: 0.3),
        ]).animate(_controller);
        _squashYAnimation = TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 1, end: 1.4), weight: 0.3),
          TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.2), weight: 0.4),
          TweenSequenceItem(tween: Tween(begin: 1.2, end: 1), weight: 0.3),
        ]).animate(_controller);
        break;

      case Direction.left:
      case Direction.right:
        _squashXAnimation = TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 1, end: 1.4), weight: 0.3),
          TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.2), weight: 0.4),
          TweenSequenceItem(tween: Tween(begin: 1.2, end: 1), weight: 0.3),
        ]).animate(_controller);
        _squashYAnimation = TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 1, end: 0.6), weight: 0.3),
          TweenSequenceItem(tween: Tween(begin: 0.6, end: 0.8), weight: 0.4),
          TweenSequenceItem(tween: Tween(begin: 0.8, end: 1), weight: 0.3),
        ]).animate(_controller);
        break;

      default:
        _squashXAnimation = const AlwaysStoppedAnimation(1);
        _squashYAnimation = const AlwaysStoppedAnimation(1);
    }

    // Анимация "отскока" для длинных перемещений
    _bounceAnimation = isLongMove
        ? TweenSequence<double>([
            TweenSequenceItem(tween: Tween(begin: 0, end: -0.1), weight: 0.2),
            TweenSequenceItem(
              tween: Tween(begin: -0.1, end: 0.05),
              weight: 0.3,
            ),
            TweenSequenceItem(tween: Tween(begin: 0.05, end: 0), weight: 0.5),
          ]).animate(_controller)
        : const AlwaysStoppedAnimation(0);

    _scaleAnimation = const AlwaysStoppedAnimation(1);
    _opacityAnimation = const AlwaysStoppedAnimation(1);
  }

  void _setupStaticAnimations() {
    _positionAnimation = const AlwaysStoppedAnimation(Offset.zero);
    _scaleAnimation = const AlwaysStoppedAnimation(1);
    _opacityAnimation = const AlwaysStoppedAnimation(1);
    _squashXAnimation = const AlwaysStoppedAnimation(1);
    _squashYAnimation = const AlwaysStoppedAnimation(1);
    _bounceAnimation = const AlwaysStoppedAnimation(0);
  }

  void _startAnimation() {
    _controller.forward().then((_) {
      widget.onAnimationComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (context, child) {
      final bounceOffset = _bounceAnimation.value * widget.elementSize;
      final direction = widget.animatedBall.moveDirection;

      var bounceDelta = Offset.zero;
      switch (direction) {
        case Direction.up:
          bounceDelta = Offset(0, bounceOffset);
          break;
        case Direction.down:
          bounceDelta = Offset(0, -bounceOffset);
          break;
        case Direction.left:
          bounceDelta = Offset(bounceOffset, 0);
          break;
        case Direction.right:
          bounceDelta = Offset(-bounceOffset, 0);
          break;
        default:
          bounceDelta = Offset.zero;
      }

      return Transform.translate(
        offset: Offset(
          _positionAnimation.value.dx * widget.elementSize + bounceDelta.dx,
          _positionAnimation.value.dy * widget.elementSize + bounceDelta.dy,
        ),
        child: Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: _buildAdvancedDeformedBall(),
          ),
        ),
      );
    },
  );

  Widget _buildAdvancedDeformedBall() => Transform(
    alignment: Alignment.center,
    transform: Matrix4.diagonal3Values(
      _squashXAnimation.value,
      _squashYAnimation.value,
      1,
    ),
    child: _buildBallContent(),
  );

  Widget _buildBallContent() => Container(
    width: widget.elementSize,
    height: widget.elementSize,
    padding: EdgeInsets.all(widget.elementSize * 0.1),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [_getBallColor(), _getBallColor().withOpacity(0.7)],
          stops: const [0.5, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
            color: _getBallColor().withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
    ),
  );

  Color _getBallColor() {
    switch (widget.animatedBall.ball.color) {
      case ItemColor.green:
        return AppConstants.ballGreen;
      case ItemColor.red:
        return AppConstants.ballRed;
      case ItemColor.blue:
        return AppConstants.ballBlue;
      case ItemColor.yellow:
        return AppConstants.ballYellow;
      case ItemColor.purple:
        return AppConstants.ballPurple;
      case ItemColor.cyan:
        return AppConstants.ballCyan;
      case ItemColor.gray:
        return AppConstants.blockGray;
    }
  }
}
