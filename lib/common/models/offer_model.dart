
class OfferModel {
  final bool? valid;
  final String? offerCode;
  final String? discountType;
  final int? discountValue;
  final int? orderValue;
  final int? discountAmount;
  final double? total;

  OfferModel({
    this.valid,
    this.offerCode,
    this.discountType,
    this.discountValue,
    this.orderValue,
    this.discountAmount,
    this.total,
  });

  OfferModel copyWith({
    bool? valid,
    String? offerCode,
    String? discountType,
    int? discountValue,
    int? orderValue,
    int? discountAmount,
    double? total,
  }) =>
      OfferModel(
        valid: valid ?? this.valid,
        offerCode: offerCode ?? this.offerCode,
        discountType: discountType ?? this.discountType,
        discountValue: discountValue ?? this.discountValue,
        orderValue: orderValue ?? this.orderValue,
        discountAmount: discountAmount ?? this.discountAmount,
        total: total ?? this.total,
      );

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    valid: json["valid"],
    offerCode: json["offer_code"],
    discountType: json["discount_type"],
    discountValue: json["discount_value"],
    orderValue: json["order_value"],
    discountAmount: json["discount_amount"],
    total: json["total"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "valid": valid,
    "offer_code": offerCode,
    "discount_type": discountType,
    "discount_value": discountValue,
    "order_value": orderValue,
    "discount_amount": discountAmount,
    "total": total,
  };
}
