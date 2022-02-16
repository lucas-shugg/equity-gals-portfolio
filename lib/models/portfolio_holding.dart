import 'stock.dart';

class PortfolioHolding {
  final double holdingWeight;

  final Stock stock;

  double get holdingWeightAsPercentage => holdingWeight * 100;

  PortfolioHolding(this.stock, this.holdingWeight);
}
