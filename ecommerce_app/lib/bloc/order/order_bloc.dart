import 'package:ecommerce_app/bloc/order/order_event.dart';
import 'package:ecommerce_app/bloc/order/order_state.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  FirebaseService firebaseService = FirebaseService();
  OrderBloc() : super(OrderInitial()) {
    on<PlaceOrder>((event, emit) async {
      emit(OrderLoading());
      await firebaseService.placeOrder(event.orders);
    });
  }
}
