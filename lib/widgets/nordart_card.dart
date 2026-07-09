import 'package:flutter/material.dart';

class NordArtCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const NordArtCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
