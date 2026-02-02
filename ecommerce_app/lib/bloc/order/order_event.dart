import 'package:ecommerce_app/models/order_model.dart';

abstract class OrderEvent {}

class PlaceOrder extends OrderEvent {
  final OrderModel orders;
  PlaceOrder({required this.orders});
}
