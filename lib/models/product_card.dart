import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoreit/theme/colors_theme.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  ProductCard(
      {super.key,
      required this.selcetContainer,
      required this.wishlist,
      required this.cartBtn,
      required this.productImg,
      required this.pname,
      required this.pbrand,
      required this.pRating,
      required this.pCurrentPrice,
      required this.isWishlisted,
      required this.oldPrice,
      required this.stock});
  final selcetContainer, wishlist, cartBtn;
  String productImg, pbrand, pname, pRating, stock, pCurrentPrice, oldPrice;
  final bool isWishlisted;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selcetContainer,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Container(
          height: 400,
          width: 188.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                    width: 188.5,
                    height: 189,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: GlobalColors.offwhite2,
                    ),
                    child: Center(child: Image.network(productImg))),
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: wishlist,
                    child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          color: isWishlisted
                              ? GlobalColors.red
                              : GlobalColors.deepgray,
                        ),
                        child: Center(
                            child: Icon(
                          isWishlisted
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          color: GlobalColors.offwhite2,
                        ))),
                  ),
                )
              ]),
              Text(
                pbrand,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              Text(
                pname,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_half_outlined,
                    color: GlobalColors.deepyellow,
                    size: 18,
                  ),
                  Text(
                    '${pRating} (${stock} sold)',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 12),
                  ),
                ],
              ),
              Container(
                width: 188.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          pCurrentPrice,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: GlobalColors.blue,
                              fontSize: 16),
                        ),
                        Text(
                          oldPrice,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: GlobalColors.offWhite,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: cartBtn,
                      child: Container(
                          width: 36,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7)),
                            color: GlobalColors.lightblue.withOpacity(.4),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              color: GlobalColors.lightblue,
                              size: 19,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
