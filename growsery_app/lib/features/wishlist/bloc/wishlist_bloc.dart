import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:growsery_app/data/wishlist_items.dart';
import 'package:growsery_app/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) {
    if (wishlistItems.isEmpty) {
      emit(WishlistEmptyState());
    } else {
      emit(WishlistSuccessState(wishlistItems: wishlistItems));
    }
  }

  FutureOr<void> wishlistRemoveFromWishlistEvent(
      WishlistRemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.productDataModel);
    if (wishlistItems.isEmpty) {
      emit(WishlistEmptyState());
    } else {
      emit(WishlistSuccessState(wishlistItems: wishlistItems));
    }
    emit(WishlistRemovedActionState());
  }
}
