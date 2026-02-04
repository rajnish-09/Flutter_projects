abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState{}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final Set<String> favoriteIds;
  FavoriteLoaded({required this.favoriteIds});
}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}
