// import 'dart:convert';
// import 'dart:io';
import 'package:dreamers/constants/error_handling.dart';
import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/constants/utils.dart';
import 'package:dreamers/features/story/screens/post_payment_screen.dart';
import 'package:dreamers/models/story_v1.dart';
import 'package:dreamers/providers/user_provider.dart';
// import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../common/widgets/bottom_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:dreamers/features/story/screens/post_payment_screen.dart';

// class Donate {
//   void donatePaypal({
//     required BuildContext context,
//     // required String heading,
//     // required String sub_heading,
//     // required String summary,
//     // required String full_detail,
//     // required String country,
//     // required String category,
//     // required List<File> images,
//     //required List<File> images,
//   }) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);

//     try {
//       // SharedPreferences prefs = await SharedPreferences.getInstance();
//       // String? token = prefs.getString('bearer-token');

//       void navigateToMainScreen() {
//         Navigator.pushNamed(context, BottomBar.routeName);
//       }

//       http.Response res = await http.get(
//         Uri.parse('$uri/api/paypal/create/order/'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           //'Authorization': 'Bearer $token',
//         },
//         //body: product.toJson(),
//       );

//       String url = res.body;
//       //print();
//       //String firstFiveChars = res.substring(0, 5);
//       final Uri _url = Uri.parse(url.substring(1, url.length - 1));

//       print(_url);
//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () async {
//           // _launchUrl(_url);
//           //if (await canLaunchUrl(_url)) {
//           showSnackBar(context, "Thank you!");
//           // Can this be done without return url?
//           await launchUrl(_url).then((resultingValue) {
//             Navigator.pushNamed(context, BottomBar.routeName);
//           });
//           //}
//           // else {
//           //     throw 'Could not launch $_url';
//           // }
//           // if (await canLaunchUrl(_url)) {
//           // await launchUrl(_url).then((resultingValue){
//           // Navigator.pushNamed(context, BottomBar.routeName);
//           //
//           // });
//           //
//           // } else {
//           // throw 'Could not launch $url';
//           // }
//           //await Navigator.of(context).pushReplacementNamed(redirect);
//           //showSnackBar(context, 'Story Added Successfully!');
//           //navigateToMainScreen(); // Should be better to redirect to the storypage user just added
//         },
//       );
//     } catch (e) {
//       //print(e.toString());
//       showSnackBar(context, e.toString());
//     }
//   }
// }

// // Future<void> _launchUrl(url) async {
// //   if (await canLaunchUrl(url)) {
// //     await launchUrl(url).then((resultingValue){
// //       Navigator.pushNamed(context, BottomBar.routeName);
// //
// //     });
// //
// //   } else {
// //     throw 'Could not launch $url';
// //   }
// //   // if (!await launchUrl(url)) {
// //   //   throw Exception('Could not launch $url');
// //   }
// // }

class Donate extends StatefulWidget {
  @override
  State<Donate> createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  // const PaypalPayment({Key? key, required this.amount, required this.currency})
  // void navigateToThankYouPage() {
  //   Navigator.pushNamed(context, ThankYouPage.routeName);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: WebView(
        initialUrl: 'http://127.0.0.1:8000/api/paypal/create/order/',
        javascriptMode: JavascriptMode.unrestricted,
        gestureRecognizers: Set()
          ..add(Factory<DragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
        onPageFinished: (value) {
          print(value);
        },
        navigationDelegate: (NavigationRequest request) async {
          print(request.url);
          if (request.url.contains('https://www.google.com')) {
            Navigator.pop(context);
            // navigateToThankYouPage;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ThankYouPage()),
            );
            // showSnackBar(context, "Thank you for your support!");
          }
          if (request.url.contains('http://www.cancel.com')) {
            Navigator.pop(context);
            Fluttertoast.showToast(msg: "Payment Cancelled");
          }
          // else {
          //   Navigator.pop(context);
          //   showSnackBar(context, "Payment Cancelled");
          // }

          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
