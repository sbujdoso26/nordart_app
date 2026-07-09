import '../models/calculation_result.dart';

class HeatingCalculator {
  static const List<int> panelPowers = [
    250,
    400,
    500,
    600,
    750,
    800,
    1000,
    1200,
    1400,
    2000,
    2400,
    2500,
  ];

  static int baseWatt(String buildingType) {
    switch (buildingType) {
      case 'Passzívház':
        return 25;
      case 'Új építésű, jól szigetelt':
        return 30;
      case 'Közepes állapotú, szigetelt':
        return 35;
      case 'Régi, szigeteletlen épület':
        return 40;
      default:
        return 35;
    }
  }

  static List<int> recommendedRange(int requiredWatt) {
    final maxTarget = requiredWatt + 1500;
    final Set<int> possibleTotals = {};

    void generate(int currentTotal, int depth) {
      if (depth > 5 || currentTotal > maxTarget) return;

      for (final power in panelPowers) {
        final newTotal = currentTotal + power;
        possibleTotals.add(newTotal);
        generate(newTotal, depth + 1);
      }
    }

    generate(0, 0);

    final totals = possibleTotals
        .where((total) => total >= requiredWatt)
        .toList()
      ..sort();

    if (totals.isEmpty) {
      return [requiredWatt, requiredWatt];
    }

    final min = totals.first;
    final max = totals.length > 1 ? totals[1] : min;

    return [min, max];
  }

  static CalculationResult calculate({
    required double area,
    required double height,
    required String buildingType,
    required bool bathroom,
    required double temperature,
  }) {
    int wattPerCubicMeter = baseWatt(buildingType);

    if (bathroom) wattPerCubicMeter += 5;
    if (temperature > 23) wattPerCubicMeter += 5;

    final volume = area * height;
    final totalWatt = (volume * wattPerCubicMeter).round();
    final recommended = recommendedRange(totalWatt);

    return CalculationResult(
      area: area,
      height: height,
      volume: volume,
      buildingType: buildingType,
      bathroom: bathroom,
      temperature: temperature,
      wattPerCubicMeter: wattPerCubicMeter,
      totalWatt: totalWatt,
      recommendedMinWatt: recommended[0],
      recommendedMaxWatt: recommended[1],
    );
  }
}