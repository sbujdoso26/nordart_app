import 'package:flutter/material.dart';
import '../constants/app_contact.dart';
import '../theme/nordart_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/nordart_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Névjegy'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Image.asset(
            'assets/logo.png',
            height: 90,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 28),
          Text(
            'NordArt',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'Fűtési teljesítmény kalkulátor',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Verzió: 1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 28),
          const InfoCard(
            text:
                'A megfelelő fűtési teljesítmény kiválasztása az első lépés a gazdaságos elektromos fűtéshez.',
          ),
          const SizedBox(height: 20),
          NordArtCard(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: NordArtTheme.primaryRed,
                  ),
                  title: Text('Weboldal'),
                  subtitle: Text(AppContact.website),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    color: NordArtTheme.primaryRed,
                  ),
                  title: Text('E-mail'),
                  subtitle: Text(AppContact.email),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.phone_outlined,
                    color: NordArtTheme.primaryRed,
                  ),
                  title: Text('Telefon'),
                  subtitle: Text(AppContact.phone),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            '© 2026 NordArt\nMinden jog fenntartva.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}