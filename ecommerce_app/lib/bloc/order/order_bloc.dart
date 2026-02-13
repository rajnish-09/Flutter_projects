import 'package:ecommerce_app/bloc/order/order_event.dart';
import 'package:ecommerce_app/bloc/order/order_state.dart';
import 'package:ecommerce_app/models/order_with_user.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  FirebaseService firebaseService = FirebaseService();
  OrderBloc() : super(OrderInitial()) {
    on<PlaceOrder>((event, emit) async {
      emit(OrderLoading());
      await firebaseService.placeOrder(event.orders);
      await firebaseService.clearCart();
      emit(OrderSuccess(msg: 'Products ordered successfully'));
    });

    on<FetchOrders>((event, emit) async {
      try {
        emit(OrderLoading());
        final orders = await firebaseService.getOrderItems();
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        print(e.toString());
      }
    });

    on<FetchAllOrders>((event, emit) async {
      try {
        emit(OrderLoading());
        final orders = await firebaseService.getAllOrders();
        List<OrderWithUser> completeOrders = await Future.wait(
          orders.map((order) async {
            final user = await firebaseService.getOrderUserData(order.userId);
            return OrderWithUser(order: order, user: user);
          }).toList(),
        );
        emit(AllOrdersLoaded(orders: completeOrders));
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
