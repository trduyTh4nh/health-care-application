import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PayPal Checkout",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckout(
                sandboxMode: true,
                clientId: "AWT3S_MSMRg62AQDEotKcZx-04Lek3APj48M6S0Lvm2eNFLuVhunAxYF7dEXW0wX7dAcVCPFpFNQkznE",
                secretKey: "EJfpAGaYHV3jwZpZ5tBxpDKlDKMjpaeLDviFhQtRuVvPuNl3jfPRVLCLr2Dm9KOe-oI2CZssTHBEmw9q",
                returnURL: "success.snippetcoder.com",
                cancelURL: "cancel.snippetcoder.com",
                transactions: const [
                  {
                    "amount": {
                      "total": '70',
                      "currency": "USD",
                      "details": {
                        "subtotal": '70',
                        "shipping": '0',
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",
                    // "payment_options": {
                    //   "allowed_payment_method":
                    //       "INSTANT_FUNDING_SOURCE"
                    // },
                    "item_list": {
                      "items": [
                        {
                          "name": "Apple",
                          "quantity": 4,
                          "price": '5',
                          "currency": "USD"
                        },
                        {
                          "name": "Pineapple",
                          "quantity": 5,
                          "price": '10',
                          "currency": "USD"
                        }
                      ],
                      // shipping address is not required though
                        "shipping_address": {
                          "recipient_name": "Raman Singh",
                          "line1": "phường 3, quận 3",
                          "city": "TP. Hồ Chí Minh",
                          "country_code": "IN",
                          "postal_code": "11001",
                          "phone": "+00000000",
                          "state": "Texas"
                       },
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("onSuccess: $params");
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ));
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(1),
              ),
            ),
          ),
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}