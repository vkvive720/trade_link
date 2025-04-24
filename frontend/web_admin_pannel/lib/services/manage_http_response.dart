import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Function to show a snackbar with a given message
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

// Function to handle different HTTP responses
void manageHttpResponse({
  required http.Response response, // The HTTP response from the request
  required BuildContext context, // Context is used to show a Snackbar
  required VoidCallback onSuccess, // Callback to execute on a successful response
}) {
  // Switch statement to handle different HTTP status codes
  switch (response.statusCode) {
    case 200: // Status code 200 indicates a successful request
      onSuccess();
      showSnackBar(context, "sucess_200");
      break;

    case 400: // Status code 400 indicates a bad request
      showSnackBar(context, json.decode(response.body)['message']);
      break;

    case 500: // Status code 500 indicates a server error
      showSnackBar(context, "Internal Server Error");
      break;

    case 201: // Status code 201 indicates a resource was created sucessfully
    onSuccess();
      showSnackBar(context, "Sucess");
      break;

    default: // Handle other unexpected status codes
      showSnackBar(context, "Unexpected Error: ${response.statusCode}");
      break;
  }
}
