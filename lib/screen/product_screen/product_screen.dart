import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/event_bus/event_bus.dart';
import 'package:rejolute/http/response/product_response/product_response.dart';
import 'package:rejolute/router.dart';
import 'package:rejolute/screen/product_screen/bloc/product_screen_bloc.dart';
import 'package:rejolute/screen/product_screen/bloc/product_screen_event.dart';
import 'package:rejolute/screen/product_screen/bloc/product_screen_state.dart';
import 'package:rejolute/util/app_utils.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/font.dart';
import 'package:rejolute/util/image_resource.dart';
import 'package:rejolute/widget/common_widget.dart';
import 'package:rejolute/widget/custom_app_bar.dart';
import 'package:rejolute/widget/custom_text.dart';
import 'package:rejolute/widget/loading_animation.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductBloc? productBloc;
  final _scrollControllerUser = ScrollController();
  final _scrollThreshold = 200.0;
  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    _scrollControllerUser.addListener(_onProductListScroll);
    eventBus.on<CartDataUpdateEvent>().listen((event) {
      productBloc!.add(CartUpdateEvent());
    });
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
    return BlocListener<ProductBloc, ProductState>(
      listener: (BuildContext context, ProductState state) {
        if (state is ProductInitialState) {
          if (state.error != null) {
            AppUtils.showToast(state.error!);
          }
        }
        if (state is SuccessCartData) {
          AppUtils.showToast("Product added in cart",
              backgroundColor: Colors.green);
        }
      },
      bloc: productBloc,
      child: BlocBuilder<ProductBloc, ProductState>(
        bloc: productBloc,
        builder: (BuildContext context, ProductState state) {
          return AbsorbPointer(
            absorbing: state is ProductLoadingState,
            child: Stack(children: <Widget>[
              buildMainBody(state),
              if (state is ProductLoadingState)
                const LoadingAnimationIndicator()
            ]),
          );
        },
      ),
    );
  }

  Widget buildMainBody(ProductState state) {
    return Container(
      child: Column(
        children: [
          buildAppBarCustom(),
          Expanded(
            child: buildProduct(),
          ),
        ],
      ),
    );
  }

  Widget buildAppBarCustom() {
    return CustomAppBar(
      appBarBackgroundColor: ColorResource.PRIMARY,
      centerWidget: Image.asset(
        ImageResource.APP_LOGO,
        height: 30,
      ),
      onTrailingWidgetActionPressed: () {
        Navigator.pushNamed(context, AppRoutes.CART_SCREEN);
      },
      trailingWidget: InkWell(
        child: Stack(children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: null,
          ),
          productBloc!.lstCartData!.length == 0
              ? Container()
              : Positioned(
                  right: 0,
                  top: 0,
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.brightness_1,
                          size: 20.0, color: Colors.green[800]),
                      Positioned(
                          top: 0.0,
                          right: 0.0,
                          left: 0,
                          bottom: 0,
                          child: Center(
                            child: Text(
                              productBloc!.lstCartData!.length.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                    ],
                  ))
        ]),
      ),
    );
  }

  Widget buildProduct() {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = 200;
    final double itemWidth = size.width / 2;
    var productLength = productBloc!.lstProductList!.length;
    if (productBloc!.isLastPageProduct &&
        !productBloc!.isLoadingProduct &&
        productLength == 0)
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: CustomText(
            "No Product Available Yet",
            //StringResource.ENGAGEMENTS_NOT_AVAILABLE_YET,
            fontSize: 17,
            color: ColorResource.WARM_GREY_979797,
            font: Font.SfUiBold,
          ),
        ),
      );
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        controller: _scrollControllerUser,
        children: [
          for (int index = 0;
              index <
                  (this.productBloc!.isLastPageProduct
                      ? productLength
                      : productLength + 1);
              index++)
            index >= productLength
                ? Container(
                    height: 50,
                    child: LoadingAnimationIndicator(
                      width: 40,
                      height: 40,
                    ),
                  )
                : productItem(index)
        ],
      ),
    );
  }

  Widget productItem(int index) {
    Product productObj = productBloc!.lstProductList![index];
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      color: Colors.grey[200],
      child: Column(
        children: [
          Expanded(child: Image.network(productObj.featuredImage.toString())),
          Row(
            children: [
              Expanded(
                child: CustomText(AppUtils.truncateWithEllipsis(
                    20, productObj.title.toString())),
              ),
              InkWell(
                onTap: () {
                  productBloc!.add(ProductAddCart(index));
                },
                child: Icon(Icons.shopping_cart),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onProductListScroll() {
    final maxScroll = _scrollControllerUser.position.maxScrollExtent - 200;
    final currentScroll = _scrollControllerUser.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (!this.productBloc!.isLastPageProduct) {
        if (!this.productBloc!.isLoadingProduct) {
          this.productBloc!.isLoadingProduct = true;
          this.productBloc!.add(ProductGetEvent());
        }
      }
    }
  }
}
