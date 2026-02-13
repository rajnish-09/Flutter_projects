import 'package:ecommerce_app/models/order_model.dart';
import 'package:ecommerce_app/models/order_with_user.dart';
import 'package:ecommerce_app/screens/admin_module/orders_screen.dart';

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

class AllOrdersLoaded extends OrderState {
  final List<OrderWithUser> orders;
  AllOrdersLoaded({required this.orders});
}
