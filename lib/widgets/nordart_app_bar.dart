import 'package:flutter/material.dart';
import '../screens/about_screen.dart';

class NordArtAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const NordArtAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          tooltip: 'Névjegy',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AboutScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}