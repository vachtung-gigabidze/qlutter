// models/animated_ball.dart
import 'package:qlutter/ver_2/models/coordinates.dart';
import 'package:qlutter/ver_2/models/item.dart';

// models/animated_ball.dart
class AnimatedBall {
  // Направление движения для деформации

  const AnimatedBall({
    required this.ball,
    required this.currentPosition,
    this.targetPosition,
    this.isMoving = false,
    this.isCaptured = false,
    this.moveDirection,
  });
  final Ball ball;
  final Coordinates currentPosition;
  final Coordinates? targetPosition;
  final bool isMoving;
  final bool isCaptured;
  final Direction? moveDirection;

  AnimatedBall copyWith({
    Ball? ball,
    Coordinates? currentPosition,
    Coordinates? targetPosition,
    bool? isMoving,
    bool? isCaptured,
    Direction? moveDirection,
  }) => AnimatedBall(
    ball: ball ?? this.ball,
    currentPosition: currentPosition ?? this.currentPosition,
    targetPosition: targetPosition ?? this.targetPosition,
    isMoving: isMoving ?? this.isMoving,
    isCaptured: isCaptured ?? this.isCaptured,
    moveDirection: moveDirection ?? this.moveDirection,
  );
}
