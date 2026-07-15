import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/about_screen.dart';

class NordArtAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NordArtAppBar({
    super.key,
    required this.title,
  });

  Future<void> _openNordArtWebsite(BuildContext context) async {
    final uri = Uri.parse('https://nordart.hu');

    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A NordArt weboldala nem nyitható meg.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.language),
          tooltip: 'NordArt weboldal',
          onPressed: () {
            _openNordArtWebsite(context);
          },
        ),
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