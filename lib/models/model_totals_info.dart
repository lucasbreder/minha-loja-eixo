class DealsTotalsInfo {
  final num? totalDeals;
  final num? totalDealsUnconfirmed;
  final num? totalPending;
  final Map<String, dynamic>? totalByMonth;

  DealsTotalsInfo({
    this.totalDeals,
    this.totalDealsUnconfirmed,
    this.totalPending,
    this.totalByMonth,
  });

  factory DealsTotalsInfo.fromJson(Map<String, dynamic> json) {
    return DealsTotalsInfo(
      totalDeals: json['total_deals'],
      totalDealsUnconfirmed: json['total_deals_unconfirmed'],
      totalPending: json['total_pending'],
      totalByMonth: json['total_by_month'],
    );
  }
}
