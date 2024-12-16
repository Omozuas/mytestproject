import 'package:http/http.dart'
    as http; // Imports the http package for making HTTP requests.
import 'package:http/http.dart'; // Imports the Response class to handle HTTP responses.

class ServicesApi {
  final String baseUrl; // Base URL for the API endpoint.

  // Constructor to initialize the base URL. The `required` keyword ensures that a baseUrl is passed when creating an instance.
  ServicesApi({required this.baseUrl});

  // Method to perform an HTTP GET request.
  Future<Response> get() async {
    // Sends an HTTP GET request to the provided base URL.
    var response = await http.get(
      Uri.parse(baseUrl), // Converts the baseUrl string into a Uri object.
      headers: {
        'Content-Type':
            'application/json', // Specifies JSON as the expected response format.
        // 'Authorization': 'Bearer $token', // (Commented out) Can be used for API authorization if needed.
      },
    )
        // Adds a timeout for the request. If the server takes longer than 40 seconds to respond, the request will fail.
        .timeout(const Duration(seconds: 40));

    return response; // Returns the HTTP response object.
  }
}
