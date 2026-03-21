import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.isLoading = false, required this.onPress,

  });

 
  final Function() onPress;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        isLoading? 'Loging in...' : 'Login',
      ),
    );
  }
}