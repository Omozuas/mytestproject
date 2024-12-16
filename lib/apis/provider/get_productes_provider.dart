import 'dart:async'; // For handling asynchronous operations, such as HTTP requests.
import 'package:flutter/material.dart'; // Provides core Flutter widgets, Material design, and ChangeNotifier.
import 'package:scoreit/apis/connectionUrl/connectionUrl.dart'; // Imports the ConnectionUrl class to manage the base URL for API calls.
import 'package:scoreit/apis/model/product_model.dart'; // Imports the GetProducts model to handle product data.
import 'package:scoreit/apis/service/services_api.dart'; // Imports ServicesApi to handle HTTP requests.

// Defines the GetProductesProvider class, which uses ChangeNotifier to notify listeners (e.g., UI widgets) about state changes.
class GetProductesProvider with ChangeNotifier {
  // Initializes the ServicesApi instance to make API requests using the base URL.
  ServicesApi apiService = ServicesApi(
    baseUrl: Connectionurl()
        .baseUrl, // Fetches the base URL for API requests from ConnectionUrl.
  );

  // Private variable to track the loading state.
  bool _productLoading = false;

  // Getter to expose the loading state to other parts of the app.
  bool get productLoading => _productLoading;

  // Private variable to hold the list of products fetched from the API.
  List<GetProducts>? _getProducts = [];

  // Getter to expose the list of products to other parts of the app.
  List<GetProducts>? get getProductsList => _getProducts;

  // Private method to update the loading state and notify listeners.
  void _setIoading(bool loading) {
    _productLoading = loading; // Updates the loading state.
  }

  // Asynchronous method to fetch products from the API.
  Future<List<GetProducts>?> getProducts() async {
    try {
      _setIoading(
          true); // Sets loading state to true before starting the API request.

      // Sends an HTTP GET request using the ServicesApi instance.
      final response = await apiService.get();

      // Parses the response body into a list of GetProducts objects.
      final parsedProducts = getProductsFromJson(response.body) ?? [];

      // Filters the parsed list to exclude null values (if any) and converts it to a list of non-null GetProducts.
      _getProducts = parsedProducts
          .whereType<
              GetProducts>() // Ensures only non-null elements are included.
          .toList();

      _setIoading(
          false); // Sets loading state to false after fetching the data.
      notifyListeners(); // Notifies listeners (e.g., UI) about the state change.

      return _getProducts; // Returns the fetched list of products.
    } catch (e) {
      // If an error occurs during the API request:
      _setIoading(false); // Sets loading state to false.
      _getProducts =
          []; // Sets the product list to an empty list to handle errors gracefully.
      notifyListeners(); // Notifies listeners about the state change.
      return _getProducts; // Returns the empty list.
    }
  }
}
