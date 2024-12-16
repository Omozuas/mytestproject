import 'package:flutter/material.dart'; // Core Flutter widgets.
import 'package:provider/provider.dart'; // For managing state with Provider.
import 'package:scoreit/apis/provider/get_productes_provider.dart'; // Imports the GetProductesProvider class.
import 'package:scoreit/models/product_card.dart'; // Imports the ProductCard widget for displaying individual products.

/// The main home screen widget that fetches and displays a grid of products.
class HomeSreen extends StatefulWidget {
  const HomeSreen({super.key});

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

/// Manages the state and lifecycle of the HomeSreen widget.
class _HomeSreenState extends State<HomeSreen> {
  @override
  void initState() {
    super.initState();

    /// Fetches the products from the API when the widget is first initialized.
    getProducts();
  }

  /// Triggers the `getProducts()` method in the provider to fetch products.
  void getProducts() {
    final products = Provider.of<GetProductesProvider>(context, listen: false);
    products.getProducts().then((onValue) {
      if (onValue == null) return; // Handles null cases gracefully.
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Watches the `GetProductesProvider` for state updates (e.g., loading or data changes).
    final loading = context.watch<GetProductesProvider>();
    return Scaffold(
      backgroundColor: Colors.white, // Sets the background color of the app.
      body: SafeArea(
        /// Ensures content is displayed within the safe area of the device.
        child: Column(
          children: [
            /// Displays a title at the top of the screen.
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'my products list',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            /// Expands to fill the remaining space with the product grid.
            Expanded(
              child: Consumer<GetProductesProvider>(
                /// Rebuilds the UI whenever the provider's state changes.
                builder: (context, value, child) {
                  /// Displays a loading spinner while products are being fetched.
                  if (value.productLoading == true) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  /// Handles the case where no products are available.
                  if (value.getProductsList == null ||
                      value.getProductsList!.isEmpty) {
                    return const Center(child: Text('No products available.'));
                  }

                  /// Displays the fetched products in a grid format.
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two items per row.
                      crossAxisSpacing: 8.0, // Space between columns.
                      mainAxisSpacing: 8.0, // Space between rows.
                      childAspectRatio: 0.7, // Aspect ratio for each grid item.
                    ),
                    itemCount: value.getProductsList?.length ??
                        0, // Number of items to display.
                    itemBuilder: (context, index) {
                      /// Fetches individual product data to pass to the ProductCard widget.
                      final item = value.getProductsList![index];
                      return ProductCard(
                        selcetContainer: () {}, // Function to handle selection.
                        wishlist: () {}, // Function to handle wishlist.
                        cartBtn: () {}, // Function to handle "Add to Cart".
                        productImg:
                            item.image ?? '', // Displays the product image.
                        pname: item.title ?? '', // Displays the product title.
                        pbrand: item
                            .category!.name, // Displays the product category.
                        pRating: item.rating?.rate.toString() ??
                            '', // Displays the product rating.
                        pCurrentPrice: item.price
                            .toString(), // Displays the product price.
                        isWishlisted:
                            false, // Indicates if the item is wishlisted.
                        oldPrice: '00', // Placeholder for the old price.
                        stock: 'yes', // Placeholder for stock status.
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
