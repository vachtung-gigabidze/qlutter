import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/constants/app_constants.dart';

class AppMenuButton extends StatelessWidget {
  const AppMenuButton({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8),
    child: Container(
      width: AppConstants.navButtonSize,
      height: AppConstants.navButtonSize,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff722FC0), Color(0xff8F5CEC)],
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 2),
            color: Colors.black.withOpacity(0.6),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(AppConstants.navButtonRound),
      ),
      child: child, // const Icon(Icons.refresh),
    ),
  );
}
