
enum StatType {
  weekly,
  monthly,
}
extension StatTypeExtension on StatType {
  String get label {
    switch (this) {
      case StatType.weekly:
        return "Week";
      case StatType.monthly:
        return "Month";
    }
  }
}
