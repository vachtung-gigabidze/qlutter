import 'package:flutter/material.dart';
import 'package:qlutter/app/di/init_di.dart';
import 'package:qlutter/app/ui/components/app_palette.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backGroundColor = const Color(0xFF165932),
  });

  final VoidCallback onPressed;
  final String text;
  final Color backGroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 232,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          ),
          fixedSize: WidgetStateProperty.all<Size>(
            const Size(double.maxFinite, 40),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(backGroundColor),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: locator.get<Palette>().fontMain,
            fontSize: 16,
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
