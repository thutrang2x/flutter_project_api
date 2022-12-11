// import 'dart:convert';
// import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// void httpErrorHandle({
//   http.Response response,
//   BuildContext context,
//   VoidCallback onSuccess,
// }) {
//   switch (response.statusCode) {
//     case 200:
//       onSuccess();
//       break;
//     case 400:
//       showSnackBar(context, jsonDecode(response.body)['msg']);
//       break;
//     case 500:
//       showSnackBar(context, jsonDecode(response.body)['error']);
//       break;
//     default:
//       showSnackBar(context, response.body);
//   }
// }

// void showSnackBar(BuildContext context, String text) {
//   try {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(text),
//       ),
//     );
//   } catch (_) {}
// }
