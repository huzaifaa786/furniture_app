import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentService extends GetxController {
  static PaymentService get instance => Get.find();
  var paymentIntent;
  String? paymentID;

/////////////////////////Call this function to stripe payment method///////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

  makePayment(int amount) async {
    try {
      paymentIntent = null;
      //Step 1: Generate Payment Intent
      paymentIntent = await createPaymentIntent(amount.toString(), 'aed');
      paymentID = paymentIntent['id'];
      //Step 2: Payment Sheet Initialization
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntent!['client_secret'],
                style: ThemeMode.light,
                // applePay: PaymentSheetApplePay(merchantCountryCode: 'UAE'),
                googlePay: PaymentSheetGooglePay(
                  merchantCountryCode: 'UAE',
                  currencyCode: 'AED',
                  testEnv: false,
                ),
                merchantDisplayName: 'Ezmove'),
          )
          .then((value) {});
      //Step 3: Display Payment Sheet
      final success = await displayPaymentSheet();
      if (success) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

//////////////////////////////////Create Payment Intent//////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };
      print(body);
      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print(response.body);
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//////////////////////////////////Display Payment Sheet/////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
  Future<bool> displayPaymentSheet() async {
    final completer = Completer<bool>();
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        paymentIntent = null;
        completer.complete(true);
      }).onError((error, stackTrace) {
        print('Error: $error');
        completer.complete(false);
      });
    } on StripeException catch (e) {
      print('StripeException: $e');
      completer.complete(false);
    } catch (e) {
      print('Error: $e');
      completer.complete(false);
    }
    return completer.future;
  }

///////////////////////////// Convert AED to cents (1 AED = 100 fils)/////////////////////////
  String calculateAmount(String amountInAED) {
    final double amountInAEDDouble = double.tryParse(amountInAED) ?? 0.0;
    final int amountInCents = (amountInAEDDouble * 100).round();
    return amountInCents.toString();
  }
}
