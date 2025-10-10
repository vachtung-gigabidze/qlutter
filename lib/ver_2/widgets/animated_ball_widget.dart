// widgets/animated_ball_widget.dart
import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/constants/app_constants.dart';
import 'package:qlutter/ver_2/models/animated_ball.dart';
import 'package:qlutter/ver_2/models/coordinates.dart';
import 'package:qlutter/ver_2/models/item.dart';

class AnimatedBallWidget extends StatefulWidget {
  const AnimatedBallWidget({
    required this.animatedBall,
    required this.elementSize,
    super.key,
    this.onAnimationComplete,
  });
  final AnimatedBall animatedBall;
  final double elementSize;
  final VoidCallback? onAnimationComplete;

  @override
  State<AnimatedBallWidget> createState() => _AnimatedBallWidgetState();
}

class _AnimatedBallWidgetState extends State<AnimatedBallWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _squashAnimation; // Анимация сплющивания

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
  void didUpdateWidget(AnimatedBallWidget oldWidget) {
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
      // Анимация захвата шара (исчезновение)
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
      _squashAnimation = const AlwaysStoppedAnimation(1);
    } else if (ball.isMoving && ball.targetPosition != null) {
      // Анимация перемещения с деформацией
      final dx = (ball.targetPosition!.x - ball.currentPosition.x).toDouble();
      final dy = (ball.targetPosition!.y - ball.currentPosition.y).toDouble();

      _positionAnimation =
          Tween<Offset>(begin: Offset.zero, end: Offset(dx, dy)).animate(
            CurvedAnimation(
              parent: _controller,
              curve: AppConstants.ballMoveCurve,
            ),
          );

      // Анимация сплющивания/растягивания
      _squashAnimation = Tween<double>(
        begin: 1,
        end: _calculateSquashFactor(ball.moveDirection),
      ).animate(CurvedAnimation(parent: _controller, curve: _getSquashCurve()));

      _scaleAnimation = const AlwaysStoppedAnimation(1);
      _opacityAnimation = const AlwaysStoppedAnimation(1);
    } else {
      // Статичное положение
      _positionAnimation = const AlwaysStoppedAnimation(Offset.zero);
      _scaleAnimation = const AlwaysStoppedAnimation(1);
      _opacityAnimation = const AlwaysStoppedAnimation(1);
      _squashAnimation = const AlwaysStoppedAnimation(1);
    }
  }

  double _calculateSquashFactor(Direction? direction) {
    switch (direction) {
      case Direction.left:
      case Direction.right:
        return 0.7; // Сплющивание по горизонтали
      case Direction.up:
      case Direction.down:
        return 1.3; // Растягивание по вертикали
      case Direction.nowhere:
      default:
        return 1; // Нормальная форма
    }
  }

  Curve _getSquashCurve() {
    // Создаем сложную кривую для реалистичной деформации
    return CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.5, curve: Curves.easeInOut),
      reverseCurve: const Interval(0.5, 1, curve: Curves.easeInOut),
    ).curve;
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
    builder: (context, child) => Transform.translate(
      offset: Offset(
        _positionAnimation.value.dx * widget.elementSize,
        _positionAnimation.value.dy * widget.elementSize,
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Opacity(
          opacity: _opacityAnimation.value,
          child: _buildDeformedBall(),
        ),
      ),
    ),
  );

  Widget _buildDeformedBall() {
    final direction = widget.animatedBall.moveDirection;
    final squashValue = _squashAnimation.value;

    var scaleX = 1.0;
    var scaleY = 1.0;

    // Применяем деформацию в зависимости от направления
    switch (direction) {
      case Direction.left:
      case Direction.right:
        scaleX = squashValue; // Сплющивание по X
        scaleY = 2.0 - squashValue; // Растягивание по Y (компенсация)
        break;
      case Direction.up:
      case Direction.down:
        scaleX = 2.0 - squashValue; // Растягивание по X (компенсация)
        scaleY = squashValue; // Сплющивание по Y
        break;
      case Direction.nowhere:
      default:
        scaleX = 1.0;
        scaleY = 1.0;
    }

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.diagonal3Values(scaleX, scaleY, 1),
      child: _buildBallContent(),
    );
  }

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
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
            color: _getBallColor().withOpacity(0.6),
            blurRadius: 6,
            offset: const Offset(-1, -1),
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
