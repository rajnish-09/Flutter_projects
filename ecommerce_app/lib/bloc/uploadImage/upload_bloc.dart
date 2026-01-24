import 'dart:io';

import 'package:ecommerce_app/bloc/uploadImage/upload_event.dart';
import 'package:ecommerce_app/bloc/uploadImage/upload_state.dart';
import 'package:ecommerce_app/service/image_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  ImageService imageService;
  File? imageFile;
  UploadBloc(this.imageService) : super(UploadInitial()) {
    on<UploadImage>((event, emit) async {
      try {
        emit(UploadingImage());
        imageFile = await imageService.pickImageFromGallery();
        if (imageFile != null) {
          final String imageURl = await imageService.uploadImage(imageFile);
          emit(UploadedImage(imageURl));
        } else {
          emit(UploadInitial());
        }
      } catch (e) {
        emit(UploadError("Error Uploading"));
      }
    });
  }
}
