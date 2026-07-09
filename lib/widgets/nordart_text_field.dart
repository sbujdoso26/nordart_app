import 'package:flutter/material.dart';
import '../theme/nordart_theme.dart';

class NordArtTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String unit;
  final String? errorText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  const NordArtTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.unit,
    required this.icon,
    this.errorText,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: NordArtTheme.primaryRed, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            suffixText: unit,
            suffixStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}