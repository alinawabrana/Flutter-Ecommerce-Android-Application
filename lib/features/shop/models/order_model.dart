import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/personalization/models/address_model.dart';
import 'package:e_commerce_app/features/shop/models/cart_item_model.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.paymentMethod,
    required this.address,
    required this.deliveryDate,
    required this.items,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the Way'
          : 'Processing';

  static OrderModel empty() => OrderModel(
        id: '',
        userId: '',
        status: OrderStatus.cancelled,
        totalAmount: 0.0,
        orderDate: DateTime.now(),
        paymentMethod: '',
        address: AddressModel.empty(),
        deliveryDate: DateTime.now(),
        items: [],
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserId': userId,
      'Status': status.toString(),
      'TotalAmount': totalAmount,
      'OrderDate': orderDate,
      'PaymentMethod': paymentMethod,
      'Address': address?.toJson(),
      'DeliveryDate': deliveryDate,
      'Items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    if (data.isEmpty) return OrderModel.empty();

    return OrderModel(
      id: data['Id'] as String? ?? '',
      userId: data['UserId'] as String? ?? '',
      status: OrderStatus.values.firstWhere(
          (e) => e.toString() == data['Status'],
          orElse: () => OrderStatus.processing),
      totalAmount: (data['TotalAmount'] as num?)?.toDouble() ?? 0.0,
      orderDate: (data['OrderDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      paymentMethod: data['PaymentMethod'] as String? ?? 'Unknown',
      address: data['Address'] != null
          ? AddressModel.fromMap(data['Address'] as Map<String, dynamic>)
          : null,
      deliveryDate: data['DeliveryDate'] != null
          ? (data['DeliveryDate'] as Timestamp).toDate()
          : null,
      items: (data['Items'] as List<dynamic>?)
              ?.map((item) =>
                  CartItemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
