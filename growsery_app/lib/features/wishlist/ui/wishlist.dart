import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growsery_app/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:growsery_app/features/wishlist/ui/wishlist_tile_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('Wishlist Items'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listener: (context, state) {
          if (state is WishlistRemovedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item Removed From Wishlist')));
          }
        },
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        builder: (context, state) {
          // switch (state.runtimeType) {
          //   case WishlistSuccessState:
          //     final successState = state as WishlistSuccessState;
          //     return ListView.builder(
          //         itemCount: successState.wishlistItems.length,
          //         itemBuilder: (context, index) {
          //           return WishlistTileWidget(
          //               productDataModel: successState.wishlistItems[index],
          //               wishlistBloc: wishlistBloc);
          //         });
          // }
          if (state is WishlistEmptyState) {
            return const Center(
              child: Text('Your wishlist is empty.'),
            );
          } else if (state is WishlistSuccessState) {
            final successState = state;
            return ListView.builder(
              itemCount: successState.wishlistItems.length,
              itemBuilder: (context, index) {
                return WishlistTileWidget(
                  productDataModel: successState.wishlistItems[index],
                  wishlistBloc: wishlistBloc,
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
