import 'package:ecommerce_app/models/order_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final String msg;
  OrderSuccess({required this.msg});
}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  OrderLoaded({required this.orders});
}
