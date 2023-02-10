import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.obscureText = false,
      this.icon = Icons.man});

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final IconData icon;

  String? emptyValidator(String? value) {
    if (value?.isEmpty == true) {
      return "Обязательное поле";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 232,
      child: TextFormField(
        controller: controller,
        validator: emptyValidator,
        obscureText: obscureText,
        maxLines: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
          prefixIcon: Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.transparent,
            constraints: const BoxConstraints(
              maxHeight: 24.0,
              maxWidth: 24.0,
            ),
            child: Icon(
              icon,
              color: const Color(0xFFC2C2C2),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color(0xFFFFFFFF),
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color(0xFFFFFFFF),
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          hintText: labelText,
          hintStyle: const TextStyle(
            height: 2.0,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Color(0xFFC2C2C2),
          ),
        ),
      ),
    );
  }
}
