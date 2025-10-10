import 'package:flutter/material.dart';

const Color kPrimaryBlue = Color(0xFF3F64F5);
const Color kSecondaryBlue = Color(0xFFD9E2FF);
const Color kHintTextColor = Color(0xFFB4B4B4);
const Color kTextColor = Color(0xFF424242);

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: kPrimaryBlue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 92,
          height: 92,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.spa, color: kPrimaryBlue, size: 60),
          ),
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String? iconPath;
  final IconData? icon;

  const SocialLoginButton({super.key, this.iconPath, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: iconPath != null
          ? Text(
              iconPath!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kPrimaryBlue,
              ),
            )
          : Icon(icon, color: kPrimaryBlue, size: 28),
    );
  }
}

final ButtonStyle kPrimaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryBlue,
  padding: const EdgeInsets.symmetric(vertical: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  textStyle: const TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
);

InputDecoration buildInputDecoration({
  required String hintText,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: kHintTextColor),
    filled: true,
    fillColor: Colors.grey[100],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    suffixIcon: suffixIcon,
  );
}
