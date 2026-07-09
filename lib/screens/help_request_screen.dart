import '../widgets/nordart_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_contact.dart';
import '../widgets/nordart_button.dart';
import '../widgets/nordart_card.dart';

class HelpRequestScreen extends StatefulWidget {
  const HelpRequestScreen({super.key});

  @override
  State<HelpRequestScreen> createState() => _HelpRequestScreenState();
}

class _HelpRequestScreenState extends State<HelpRequestScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendRequest() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kérjük, töltsön ki minden mezőt.'),
        ),
      );
      return;
    }

    final uri = Uri(
      scheme: 'mailto',
      path: AppContact.email,
      queryParameters: {
        'subject': 'Segítségkérés NordArt Appból',
        'body':
            'Új segítségkérés érkezett a NordArt alkalmazásból.\n\n'
            'Név: $name\n'
            'E-mail: $email\n'
            'Telefonszám: $phone\n\n'
            'Kérem, vegyék fel velem a kapcsolatot.',
      },
    );

    final launched = await launchUrl(uri);

    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nem található e-mail alkalmazás a készüléken.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NordArtAppBar(
        title: 'Segítségkérés',
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Szeretnék segítséget kérni',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          const Text(
            'Adja meg elérhetőségeit, és a NordArt munkatársa visszahívja Önt.',
            style: TextStyle(height: 1.45),
          ),
          const SizedBox(height: 24),
          NordArtCard(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Név',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail cím',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Telefonszám',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          NordArtButton(
            text: 'Segítségkérés elküldése',
            icon: Icons.send_outlined,
            onPressed: _sendRequest,
          ),
        ],
      ),
    );
  }
}