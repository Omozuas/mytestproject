import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreit/apis/provider/get_productes_provider.dart';
import 'package:scoreit/models/product_card.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({super.key});

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() {
    final products = Provider.of<GetProductesProvider>(context, listen: false);
    products.getProducts().then((onValue) {
      if (onValue == null) return;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<GetProductesProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'my products list',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: Consumer<GetProductesProvider>(
              builder: (context, value, child) {
                if (value.productLoading == true) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of items per row
                    crossAxisSpacing: 8.0, // Horizontal spacing between items
                    mainAxisSpacing: 8.0, // Vertical spacing between items
                    childAspectRatio: 0.7, // Aspect ratio of each grid item
                  ),
                  itemCount: value.getProductsList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = value.getProductsList![index];
                    return ProductCard(
                        selcetContainer: () {},
                        wishlist: () {},
                        cartBtn: () {},
                        productImg: item.image ?? '',
                        pname: item.title ?? '',
                        pbrand: item.category!.name,
                        pRating: item.rating?.rate.toString() ?? '',
                        pCurrentPrice: item.price.toString(),
                        isWishlisted: false,
                        oldPrice: '00',
                        stock: 'yes');
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
