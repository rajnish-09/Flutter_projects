import 'package:ecommerce_app/bloc/category/category_event.dart';
import 'package:ecommerce_app/bloc/category/category_state.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  FirebaseService firebaseService;
  CategoryBloc(this.firebaseService) : super(CategoryInitial()) {
    on<AddCategory>((event, emit) async {
      try {
        emit(CategoryLoading());
        await firebaseService.addCategory(event.category);
      } catch (e) {
        throw Exception(e.toString());
      }
    });
  }
}
