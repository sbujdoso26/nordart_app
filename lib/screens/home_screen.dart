import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'calculator_screen.dart';
import 'help_request_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NordArt'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Image.asset(
              'assets/logo.png',
              height: 95,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 36),
            Text(
              'Fűtési teljesítmény kalkulátor',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 18),
            const Text(
              'A megfelelő teljesítmény kiválasztása az első lépés a gazdaságos elektromos fűtéshez.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Adja meg a helyiség alapterületét, belmagasságát és az épület állapotát, a kalkulátor pedig kiszámolja a szükséges fűtési teljesítményt.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.45),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CalculatorScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.bolt),
              label: const Text('Fűtési teljesítmény kiszámítása'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HelpRequestScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.support_agent),
              label: const Text('Szeretnék segítséget kérni'),
            ),
            const SizedBox(height: 20),
            const Text(
              'v1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}