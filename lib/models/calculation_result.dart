class CalculationResult {
  final double area;
  final double height;
  final double volume;
  final String buildingType;
  final bool bathroom;
  final double temperature;
  final int wattPerCubicMeter;
  final int totalWatt;
  final int recommendedMinWatt;
  final int recommendedMaxWatt;

  const CalculationResult({
    required this.area,
    required this.height,
    required this.volume,
    required this.buildingType,
    required this.bathroom,
    required this.temperature,
    required this.wattPerCubicMeter,
    required this.totalWatt,
    required this.recommendedMinWatt,
    required this.recommendedMaxWatt,
  });

  double get totalKilowatt => totalWatt / 1000;
}