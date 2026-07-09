import 'package:flutter/material.dart';
import '../models/calculation_result.dart';
import '../theme/nordart_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/nordart_button.dart';
import '../widgets/nordart_card.dart';
import '../widgets/nordart_app_bar.dart';
import 'help_request_screen.dart';

class ResultScreen extends StatelessWidget {
  final CalculationResult result;

  const ResultScreen({
    super.key,
    required this.result,
  });

  String _formatWatt(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]} ',
    );
  }

  String _formatDecimal(double value) {
    return value.toStringAsFixed(2).replaceAll('.', ',');
  }

  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: NordArtTheme.primaryRed,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wattText = _formatWatt(result.totalWatt);
    final kwText = _formatDecimal(result.totalKilowatt);

    return Scaffold(
      appBar: const NordArtAppBar(
        title: 'Számítás eredménye',
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: NordArtTheme.primaryRed,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.bolt,
                  color: Colors.white,
                  size: 46,
                ),

                const SizedBox(height: 16),

                const Text(
                  'Szükséges fűtési teljesítmény',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 26),

                Text(
                  '$wattText W',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '≈ $kwText kW',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Ajánlott teljesítménytartomány',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '${_formatWatt(result.recommendedMinWatt)} - ${_formatWatt(result.recommendedMaxWatt)} W',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  'A megfelelő fűtési teljesítmény kiválasztása az első lépés a gazdaságos elektromos fűtéshez.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.4,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'A számítás alapja',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 14),

          NordArtCard(
            child: Column(
              children: [
                _detailRow(
                  icon: Icons.square_foot_outlined,
                  label: 'Alapterület',
                  value: '${_formatDecimal(result.area)} m²',
                ),

                _detailRow(
                  icon: Icons.height,
                  label: 'Belmagasság',
                  value: '${_formatDecimal(result.height)} m',
                ),

                _detailRow(
                  icon: Icons.air_outlined,
                  label: 'Légtér',
                  value: '${_formatDecimal(result.volume)} m³',
                ),

                _detailRow(
                  icon: Icons.home_work_outlined,
                  label: 'Épület típusa',
                  value: result.buildingType,
                ),

                _detailRow(
                  icon: Icons.shower_outlined,
                  label: 'Fürdőszoba',
                  value: result.bathroom ? 'Igen' : 'Nem',
                ),

                _detailRow(
                  icon: Icons.thermostat_outlined,
                  label: 'Kívánt hőmérséklet',
                  value: '${result.temperature.toStringAsFixed(0)} °C',
                ),

                _detailRow(
                  icon: Icons.bolt_outlined,
                  label: 'Alkalmazott érték',
                  value: '${result.wattPerCubicMeter} W/m³',
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const InfoCard(
            text:
                'A számítás tájékoztató jellegű. A szükséges fűtési teljesítményt befolyásolhatja többek között a nyílászárók állapota, a tájolás, a födém és a padló hőszigetelése, valamint az épület egyéb adottságai.',
          ),

          const SizedBox(height: 24),

          NordArtButton(
            text: 'Szakértői segítséget kérek',
            icon: Icons.support_agent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HelpRequestScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          NordArtButton(
            text: 'Vissza a kalkulátorhoz',
            icon: Icons.arrow_back,
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}