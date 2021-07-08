import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/model/product_cart_data.dart';
import 'package:rejolute/screen/cart_screen/bloc/cart_screen_bloc.dart';
import 'package:rejolute/screen/cart_screen/bloc/cart_screen_event.dart';
import 'package:rejolute/screen/cart_screen/bloc/cart_screen_state.dart';
import 'package:rejolute/util/app_utils.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/widget/common_widget.dart';
import 'package:rejolute/widget/custom_text.dart';
import 'package:rejolute/widget/loading_animation.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;

  @override
  void initState() {
    super.initState();
    cartBloc = BlocProvider.of<CartBloc>(context);
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => buildAfterComplete(context));
  }

  buildAfterComplete(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // backgroundColor: ColorResource.PRIMARY,
        child: Container(
          child: layout(),
          color: ColorResource.BACKGROUND_WHITE,
        ),
      ),
    );
  }

  Widget layout() {
    return BlocListener<CartBloc, CartState>(
      listener: (BuildContext context, CartState state) {
        if (state is CartInitialState) {
          if (state.error != null) {
            AppUtils.showToast(state.error!);
          }
        }
      },
      bloc: cartBloc,
      child: BlocBuilder<CartBloc, CartState>(
        bloc: cartBloc,
        builder: (BuildContext context, CartState state) {
          return AbsorbPointer(
            absorbing: state is CartLoadingState,
            child: Stack(children: <Widget>[
              if (state is CartLoadingState)
                const LoadingAnimationIndicator()
              else
                buildMainBody(state),
            ]),
          );
        },
      ),
    );
  }

  Widget buildMainBody(CartState state) {
    return Container(
      child: Column(
        children: [
          buildAppBar(),
          Expanded(
            child: buildProduct(),
          ),
          if (cartBloc!.lstCartData!.length != 0) buildCartTotaltext(),
        ],
      ),
    );
  }

  Widget buildCartTotaltext() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(color: ColorResource.PRIMARY.withOpacity(0.2)),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              "Total Item : " + cartBloc!.lstCartData!.length.toString(),
            ),
          ),
          Expanded(
            child: CustomText(
              "Grand Total : " + cartBloc!.grnadTotal.toStringAsFixed(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProduct() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: cartBloc!.lstCartData!.length,
        itemBuilder: (context, index) {
          return cartItem(index);
        },
      ),
    );
  }

  Widget cartItem(int index) {
    ProductCartData obj = cartBloc!.lstCartData![index];
    var total = double.parse(obj.productObj!.price.toString()) * obj.qty!;
    // cartBloc!.grnadTotal = cartBloc!.grnadTotal + total;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              obj.productObj!.featuredImage.toString(),
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        cartBloc!.add(CartRemoveItem(index));
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                          "X",
                          color: Colors.red,
                        ),
                      ),
                    ),
                    CustomText(obj.productObj!.title.toString()),
                    CustomText("Price : \$" + obj.productObj!.price.toString()),
                    CustomText("Qty : " + obj.qty.toString()),
                    CustomText("Total Price : \$" + total.toStringAsFixed(2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
