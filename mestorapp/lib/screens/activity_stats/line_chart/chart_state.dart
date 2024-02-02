class ChartState {
  static final ChartState _instance = ChartState._internal();
	/// How many units the chart was scrolled to the left
  double xOffset = 0.0;
  static const paddingX = 10.0;
  static const paddingY = 10.0;
  static const labelSpaceX = 18.0;
  static const labelSpaceY = 10.0;
  static const colWidth = 18.0;
	/// How much X units will scroll per delta unit.
  static const scrollXFactor = 2.0;

  ChartState._internal();

  static ChartState get instance => _instance;
}
