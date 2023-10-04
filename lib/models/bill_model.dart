
class BillModel {
  String? name;
  int? quantity;
  double? price;
  bool? isVip;
  bool? isPay;

  BillModel({
    this.name,
    this.quantity,
    this.price,
    this.isVip,
    this.isPay,
  });

  double get totalPrice {
    if (isVip ?? false) {
      return (quantity ?? 0) * (price ?? 0) * (0.9);
    } else {
      return ((quantity ?? 0) * (price ?? 0));
    }
  }

  BillModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    isVip = json['isVip'];
    isPay = json['isPay'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'quantity': quantity, 'price': price,'isVip': isVip,'isPay': isPay,};
  }
}

final bills = [
  BillModel(
    name: 'huy',
    quantity: 3,
    price: 20000,
  ),
  BillModel(
    name: 'hoang',
    quantity: 10,
    price: 20000,
    isVip: true,
  ),
  BillModel(
    name: 'vy',
    quantity: 10,
    price: 20000,
  ),
];
