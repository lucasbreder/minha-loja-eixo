class DealsTotalsInfo {
  final num? totalDeals;
  final num? totalDealsUnconfirmed;
  final num? totalPending;

  DealsTotalsInfo({
    this.totalDeals,
    this.totalDealsUnconfirmed,
    this.totalPending,
  });

  factory DealsTotalsInfo.fromJson(Map<String, dynamic> json) {
    return DealsTotalsInfo(
      totalDeals: json['total_deals'],
      totalDealsUnconfirmed: json['total_deals_unconfirmed'],
      totalPending: json['total_pending'],
    );
  }
}
