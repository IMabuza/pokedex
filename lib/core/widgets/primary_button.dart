import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.isLoading = false, required this.onPress,
    required this.buttonText,

  });

 
  final Function() onPress;
  final bool isLoading;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        isLoading? 'Loading...' : buttonText,
      ),
    );
  }
}