import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_loan/components/cart.dart';
import 'package:med_loan/components/product.dart';
import 'package:med_loan/misc/constants.dart';
import 'package:med_loan/misc/functions.dart';
import 'package:med_loan/misc/providers.dart';

class ViewProduct extends ConsumerStatefulWidget {
  final Product product;

  const ViewProduct({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends ConsumerState<ViewProduct> {
  void decreaseOrderQuantity() {
    List<CartOrder> cart = ref.watch(cartProvider);
    int index = cart.indexWhere((order) => order.product == widget.product);
    if (index != -1) {
      CartOrder order = cart[index];
      if (order.quantity == 1) {
        ref.watch(cartProvider.notifier).state = [
          ...cart.sublist(0, index),
          ...cart.sublist(index + 1)
        ];
      } else {
        CartOrder newOrder = order.withNewQuantity(order.quantity - 1);
        ref.watch(cartProvider.notifier).state = [
          ...cart.sublist(0, index),
          newOrder,
          ...cart.sublist(index + 1),
        ];
      }
    }
  }

  int get orderQuantity {
    List<CartOrder> cart = ref.watch(cartProvider);
    int index = cart.indexWhere((order) => order.product == widget.product);
    if (index == -1) return 0;
    return cart[index].quantity;
  }

  void increaseOrderQuantity() {
    List<CartOrder> cart = ref.watch(cartProvider);
    int index = cart.indexWhere((order) => order.product == widget.product);
    if (index != -1) {
      CartOrder order = cart[index];
      CartOrder newOrder = order.withNewQuantity(order.quantity + 1);
      ref.watch(cartProvider.notifier).state = [
        ...cart.sublist(0, index),
        newOrder,
        ...cart.sublist(index + 1),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CartOrder> cart = ref.watch(cartProvider);
    int productIndex =
        cart.indexWhere((order) => order.product == widget.product);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Product Details",
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: primary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 390.w,
                  height: 250.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: DecorationImage(
                      image: AssetImage(widget.product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  widget.product.name,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "₦${formatAmount(widget.product.price.toStringAsFixed(0))}",
                      style: context.textTheme.headlineMedium!.copyWith(
                        color: primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        child: Text(
                          widget.product.category,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: light,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5.h),
                Text("In Stock: ${widget.product.stock}"),
                SizedBox(height: 10.h),
                Text(
                  widget.product.description,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        child: productIndex == -1
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(390.w, 50.h),
                  backgroundColor: primary,
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.5.r),
                  ),
                ),
                onPressed: () {
                  CartOrder order = CartOrder(product: widget.product);
                  ref.watch(cartProvider.notifier).state = [...cart, order];
                },
                child: Text(
                  "Add To Cart",
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50.h, 50.h),
                      backgroundColor: primary,
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5.r),
                      ),
                    ),
                    onPressed: decreaseOrderQuantity,
                    child: Text(
                      "-",
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "$orderQuantity",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50.h, 50.h),
                      backgroundColor: primary,
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5.r),
                      ),
                    ),
                    onPressed: increaseOrderQuantity,
                    child: Text(
                      "+",
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
