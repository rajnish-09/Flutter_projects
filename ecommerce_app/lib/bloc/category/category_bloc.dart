import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/bloc/category/category_event.dart';
import 'package:ecommerce_app/bloc/category/category_state.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  FirebaseService firebaseService;
  CategoryBloc(this.firebaseService) : super(CategoryInitial()) {
    on<AddCategory>((event, emit) async {
      try {
        emit(CategoryLoading());
        await firebaseService.addCategory(event.category);
        // emit(AddCategorySuccess());
        final List<CategoryModel> categories = await firebaseService
            .getAllCategories();
        emit(AddCategorySuccess());
        emit(CategoryLoaded(categories: categories));
      } catch (e) {
        emit(AddCategoryFailed(e.toString()));
      }
    });

    on<FetchCategories>((event, emit) async {
      emit(CategoryLoading());
      final List<CategoryModel> categories = await firebaseService
          .getAllCategories();
      emit(CategoryLoaded(categories: categories));
    });
  }
}
