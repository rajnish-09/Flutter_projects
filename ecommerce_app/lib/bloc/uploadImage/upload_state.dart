abstract class UploadState {}

class UploadInitial extends UploadState {}

class UploadingImage extends UploadState {}

class UploadedImage extends UploadState {
  final String imgUrl;
  UploadedImage(this.imgUrl);
}

class UploadError extends UploadState {
  final String errorMessage;
  UploadError(this.errorMessage);
}
