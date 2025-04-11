import 'package:flutter/material.dart';
import '../core/theme/app_decorations.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  const CustomCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: AppDecorations.cardDecoration.copyWith(
        color: backgroundColor ?? Colors.white,
      ),
      child: child,
    );
  }
}
