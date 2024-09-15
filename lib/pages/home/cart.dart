import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:med_loan/components/cart.dart';
import 'package:med_loan/misc/constants.dart';
import 'package:med_loan/misc/functions.dart';
import 'package:med_loan/misc/providers.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    List<CartOrder> orders = ref.watch(cartProvider);
    double total = 0.0;
    for (var order in orders) {
      total += order.quantity * order.product.price;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Cart",
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: primary,
          ),
        ),
        actions: [
          if (orders.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: GestureDetector(
                onTap: () => ref.watch(cartProvider.notifier).state = [],
                child: Icon(
                  IconsaxPlusBold.trash,
                  size: 26.r,
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: orders.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/No Data.png",
                        width: 200.w,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "There are no items in your cart",
                        style: context.textTheme.bodyMedium,
                      ),

                    ],
                  ),
                )
              : ListView.separated(
                  itemBuilder: (_, index) {
                    if (index == orders.length) return SizedBox(height: 10.h);
                    return OrderContainer(order: orders[index]);
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 15.h),
                  itemCount: orders.length + 1,
                ),
        ),
      ),
      bottomNavigationBar: orders.isEmpty
          ? null
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(390.w, 50.h),
                  backgroundColor: primary,
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.5.r),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Pay ₦${formatAmount(total.toStringAsFixed(0))}",
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
    );
  }
}

class OrderContainer extends ConsumerStatefulWidget {
  final CartOrder order;

  const OrderContainer({
    super.key,
    required this.order,
  });

  @override
  ConsumerState<OrderContainer> createState() => _OrderContainerState();
}

class _OrderContainerState extends ConsumerState<OrderContainer> {
  void decreaseOrderQuantity() {
    List<CartOrder> cart = ref.watch(cartProvider);
    int index =
        cart.indexWhere((order) => order.product == widget.order.product);
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

  void removeOrder() {
    List<CartOrder> cart = ref.watch(cartProvider);
    int index =
        cart.indexWhere((order) => order.product == widget.order.product);
    if (index != -1) {
      CartOrder order = cart[index];
      if (order.quantity == 1) {
        ref.watch(cartProvider.notifier).state = [
          ...cart.sublist(0, index),
          ...cart.sublist(index + 1)
        ];
      }
    }
  }

  int get orderQuantity {
    List<CartOrder> cart = ref.watch(cartProvider);
    int index =
        cart.indexWhere((order) => order.product == widget.order.product);
    if (index == -1) return 0;
    return cart[index].quantity;
  }

  void increaseOrderQuantity() {
    List<CartOrder> cart = ref.watch(cartProvider);
    int index =
        cart.indexWhere((order) => order.product == widget.order.product);
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

  final double buttonSize = 20.r;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 80.r,
          height: 80.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5.r),
            image: DecorationImage(
              image: AssetImage(widget.order.product.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          width: 320.w - 80.r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.order.product.name,
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: removeOrder,
                    child: Icon(
                      IconsaxPlusBold.trash,
                      size: 18.r,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              Text(
                "Category: ${widget.order.product.category}",
                style: context.textTheme.bodyMedium!.copyWith(
                  color: primary,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "₦${formatAmount(widget.order.product.price.toStringAsFixed(0))}",
                    style: context.textTheme.titleMedium!.copyWith(
                      color: primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.order.quantity > 1)
                        GestureDetector(
                          onTap: decreaseOrderQuantity,
                          child: Container(
                            width: buttonSize,
                            height: buttonSize,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "-",
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(width: 10.w),
                      Text(
                        "$orderQuantity",
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      GestureDetector(
                        onTap: increaseOrderQuantity,
                        child: Container(
                          width: buttonSize,
                          height: buttonSize,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "+",
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
