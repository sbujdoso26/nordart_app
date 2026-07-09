import '../widgets/nordart_app_bar.dart';
import 'package:flutter/material.dart';
import '../services/heating_calculator.dart';
import '../theme/nordart_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/nordart_button.dart';
import '../widgets/nordart_card.dart';
import '../widgets/nordart_text_field.dart';
import '../widgets/section_title.dart';
import 'result_screen.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final areaController = TextEditingController();
  final heightController = TextEditingController();

  String buildingType = 'Közepes állapotú, szigetelt';
  bool bathroom = false;
  int temperature = 22;

  String? areaError;
  String? heightError;

  final List<String> buildingTypes = const [
    'Passzívház',
    'Új építésű, jól szigetelt',
    'Közepes állapotú, szigetelt',
    'Régi, szigeteletlen épület',
  ];

  @override
  void dispose() {
    areaController.dispose();
    heightController.dispose();
    super.dispose();
  }

  double? _parseNumber(String value) {
    return double.tryParse(value.trim().replaceAll(',', '.'));
  }

  String _formatDecimal(double value) {
    return value.toStringAsFixed(2).replaceAll('.', ',');
  }

  int get currentWattPerCubicMeter {
    int watt = HeatingCalculator.baseWatt(buildingType);
    if (bathroom) watt += 5;
    if (temperature > 23) watt += 5;
    return watt;
  }

  double? get currentVolume {
    final area = _parseNumber(areaController.text);
    final height = _parseNumber(heightController.text);

    if (area == null || height == null || area <= 0 || height <= 0) {
      return null;
    }

    return area * height;
  }

  void _formatInputs() {
    final area = _parseNumber(areaController.text);
    final height = _parseNumber(heightController.text);

    if (area != null && area > 0) {
      areaController.text = _formatDecimal(area);
    }

    if (height != null && height > 0) {
      heightController.text = _formatDecimal(height);
    }
  }

  String get comfortText {
    if (temperature > 23) {
      return 'Magasabb komfortigény (+5 W/m³)';
    }
    return 'Normál lakóhelyiség';
  }

  void _calculate() {
    FocusScope.of(context).unfocus();

    final area = _parseNumber(areaController.text);
    final height = _parseNumber(heightController.text);

    setState(() {
      areaError = null;
      heightError = null;

      if (area == null || area <= 0) {
        areaError = 'Az alapterület megadása kötelező.';
      }

      if (height == null || height <= 0) {
        heightError = 'A belmagasság megadása kötelező.';
      }
    });

    if (areaError != null || heightError != null) return;

    _formatInputs();

    final result = HeatingCalculator.calculate(
      area: area!,
      height: height!,
      buildingType: buildingType,
      bathroom: bathroom,
      temperature: temperature.toDouble(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(result: result),
      ),
    );
  }

  void _decreaseTemperature() {
    if (temperature > 18) {
      setState(() => temperature--);
    }
  }

  void _increaseTemperature() {
    if (temperature < 30) {
      setState(() => temperature++);
    }
  }

  Widget _buildingTypeCard(String type) {
    final selected = buildingType == type;

    IconData icon;
    if (type == 'Passzívház') {
      icon = Icons.energy_savings_leaf_outlined;
    } else if (type == 'Új építésű, jól szigetelt') {
      icon = Icons.home_outlined;
    } else if (type == 'Közepes állapotú, szigetelt') {
      icon = Icons.apartment_outlined;
    } else {
      icon = Icons.house_siding_outlined;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          setState(() {
            buildingType = type;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected ? NordArtTheme.primaryRed : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? NordArtTheme.primaryRed : Colors.grey.shade300,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : NordArtTheme.primaryRed,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  type,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? Colors.white : Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _temperatureSelector() {
    return NordArtCard(
      child: Column(
        children: [
          const SectionTitle(
            title: 'Kívánt hőmérséklet',
            icon: Icons.thermostat_outlined,
          ),
          const SizedBox(height: 16),
          Text(
            '$temperature °C',
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            comfortText,
            style: TextStyle(
              color: temperature > 23 ? NordArtTheme.primaryRed : Colors.black54,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _decreaseTemperature,
                  child: const Text(
                    '−',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: _increaseTemperature,
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bathroomCard() {
    return NordArtCard(
      child: Column(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Fürdőszoba',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: const Text('+5 W/m³ korrekció'),
            value: bathroom,
            onChanged: (value) {
              setState(() {
                bathroom = value;
              });
            },
          ),
          const InfoCard(
            text:
                'Fürdőszobák esetén általában magasabb hőmérséklet az igény, ezért +5 W/m³ korrekciót alkalmazunk.',
          ),
        ],
      ),
    );
  }

  Widget _liveSummary() {
    final volume = currentVolume;

    if (volume == null) {
      return const SizedBox.shrink();
    }

    return NordArtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Előzetes összegzés',
            icon: Icons.summarize_outlined,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Légtér\n${_formatDecimal(volume)} m³',
                  style: const TextStyle(
                    height: 1.4,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Alkalmazott érték\n$currentWattPerCubicMeter W/m³',
                  style: const TextStyle(
                    height: 1.4,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NordArtAppBar(
         title: 'Kalkulátor',
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Adja meg a helyiség adatait',
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          const SizedBox(height: 20),

          NordArtCard(
            child: Column(
              children: [
                NordArtTextField(
                  controller: areaController,
                  label: 'Alapterület',
                  hint: 'pl. 25,50',
                  unit: 'm²',
                  icon: Icons.square_foot_outlined,
                  errorText: areaError,
                  onChanged: (_) => setState(() {}),
                  onEditingComplete: _formatInputs,
                ),
                const SizedBox(height: 18),
                NordArtTextField(
                  controller: heightController,
                  label: 'Belmagasság',
                  hint: 'pl. 2,70',
                  unit: 'm',
                  icon: Icons.height,
                  errorText: heightError,
                  onChanged: (_) => setState(() {}),
                  onEditingComplete: _formatInputs,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const SectionTitle(
            title: 'Épület hőszigetelése',
            icon: Icons.home_work_outlined,
          ),

          const SizedBox(height: 12),

          ...buildingTypes.map(_buildingTypeCard),

          const SizedBox(height: 16),

          _bathroomCard(),

          const SizedBox(height: 16),

          _temperatureSelector(),

          const SizedBox(height: 16),

          _liveSummary(),

          const SizedBox(height: 24),

          NordArtButton(
            text: 'Számítás',
            icon: Icons.bolt,
            onPressed: _calculate,
          ),
        ],
      ),
    );
  }
}