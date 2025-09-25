class Order {
  final String id;
  final String restaurantName;
  final String restaurantImage;
  final List<String> items;
  final double total;
  final OrderStatus status;
  final DateTime orderTime;
  final DateTime estimatedDeliveryTime;
  final String deliveryAddress;
  final String? driverName;
  final String? driverPhone;
  final String? driverImage;

  Order({
    required this.id,
    required this.restaurantName,
    required this.restaurantImage,
    required this.items,
    required this.total,
    required this.status,
    required this.orderTime,
    required this.estimatedDeliveryTime,
    required this.deliveryAddress,
    this.driverName,
    this.driverPhone,
    this.driverImage,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'restaurantName': restaurantName,
        'restaurantImage': restaurantImage,
        'items': items,
        'total': total,
        'status': status.toString(),
        'orderTime': orderTime.toIso8601String(),
        'estimatedDeliveryTime': estimatedDeliveryTime.toIso8601String(),
        'deliveryAddress': deliveryAddress,
        'driverName': driverName,
        'driverPhone': driverPhone,
        'driverImage': driverImage,
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        restaurantName: json['restaurantName'],
        restaurantImage: json['restaurantImage'],
        items: List<String>.from(json['items']),
        total: json['total'].toDouble(),
        status: OrderStatus.values.firstWhere(
          (e) => e.toString() == json['status'],
        ),
        orderTime: DateTime.parse(json['orderTime']),
        estimatedDeliveryTime: DateTime.parse(json['estimatedDeliveryTime']),
        deliveryAddress: json['deliveryAddress'],
        driverName: json['driverName'],
        driverPhone: json['driverPhone'],
        driverImage: json['driverImage'],
      );
}

enum OrderStatus {
  placed,
  confirmed,
  preparing,
  ready,
  pickedUp,
  onTheWay,
  delivered,
  cancelled
}
