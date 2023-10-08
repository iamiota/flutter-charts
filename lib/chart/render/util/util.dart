double getRound(double num, [int precision = 4]) {
  return double.parse((num).toStringAsFixed(precision));
}