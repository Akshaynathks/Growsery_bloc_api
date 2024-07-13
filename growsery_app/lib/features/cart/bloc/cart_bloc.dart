import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:growsery_app/data/cart_items.dart';
import 'package:growsery_app/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    if (cartItems.isEmpty) {
      emit(CartEmptyState());
    } else {
      emit(CartSuccessState(cartItems: cartItems));
    }
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModel);
    if (cartItems.isEmpty) {
      emit(CartEmptyState());
    }else{
    emit(CartSuccessState(cartItems: cartItems));
    }
    emit(CartRemovedActionState());
  }
}
