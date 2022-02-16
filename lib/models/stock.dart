class Stock {
  final String name;
  String? percentageGrowth;
  String? thirtyDayGrowth;
  final String info = "PDF";
  final double priceBoughtAt;

  double? currentPrice, priceThirtyDaysAgo;

  Stock(this.name, this.priceBoughtAt);

  void setCurrentPriceAndPercentageGrowth(double newCurrentPrice) {
    currentPrice = newCurrentPrice;

    percentageGrowth =
        _calculateGrowthPercentage(newCurrentPrice, priceBoughtAt)
                .toStringAsFixed(2) +
            "%";
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
