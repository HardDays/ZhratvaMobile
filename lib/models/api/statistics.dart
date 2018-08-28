class Statistics {
  int visitedPlaces;
  int itemsOrdered;
  double moneySpent;
  double moneySaved;

  Statistics({this.visitedPlaces, this.itemsOrdered, this.moneySaved, this.moneySpent});

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      visitedPlaces: json['visited_places'],
      itemsOrdered: json['items_ordered'],
      moneySpent: json['money_spent'] / 100.0,
      moneySaved: json['money_saved'] / 100.0
    );
  }

}