import 'package:ecommerce_app/models/order_model.dart';
import 'package:ecommerce_app/models/user_model.dart';

class OrderWithUser {
  final OrderModel order;
  final UserModel user;

  OrderWithUser({required this.order, required this.user});
}
