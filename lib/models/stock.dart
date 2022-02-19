class Stock {
  final String name;
  double? percentageGrowth;
  String? thirtyDayGrowth;
  final String info = "PDF";
  final double priceBoughtAt;

  double? currentPrice, priceThirtyDaysAgo;
  String? get percentageGrowthAsString => percentageGrowth != null
      ? percentageGrowth!.toStringAsFixed(2) + "%"
      : null;
  Stock(this.name, this.priceBoughtAt);

  void setCurrentPriceAndPercentageGrowth(double newCurrentPrice) {
    currentPrice = newCurrentPrice;

    percentageGrowth =
        _calculateGrowthPercentage(newCurrentPrice, priceBoughtAt);
  }

  void setPriceThirtyDaysAgo(double newPriceThirtyDaysAgo) {
    priceThirtyDaysAgo = newPriceThirtyDaysAgo;

    if (currentPrice == null) {
      return;
    }
    thirtyDayGrowth =
        _calculateGrowthPercentage(currentPrice!, newPriceThirtyDaysAgo)
                .toStringAsFixed(2) +
            "%";
  }

  double _calculateGrowthPercentage(double currentPrice, double previousPrice) {
    return (currentPrice - previousPrice) * 100 / previousPrice;
  }
}
