import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:toast/toast.dart';
import 'constants.dart';
import 'translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

double amountToBePaid = 0;
void sendAmount(double amount) {
  amountToBePaid = amount;
}

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late Razorpay razorpay;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final String text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: amountToBePaid.toString(),
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_V7WQ6qHKF4DGDk",
      "amount": num.parse(_controller.text) * 100,
      "name": "Metro Run",
      "description": "Ticket Booking",
      "prefill": {"contact": " ", "email": " "},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Payment success");
    print("Payment ID : $response.paymentId");
    myPaymentId = response.paymentId!;
    Toast.show("Payment success", context);
    Navigator.of(context).pushNamed('/qrcodepage');
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Payment error");
    Toast.show("Payment error", context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    Toast.show("External Wallet Error", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title: Text(LocaleKeys.Payment.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  prefixText: _controller.text,
                  prefixStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  helperText: LocaleKeys.Amount_to_be_paid.tr(),
                  helperStyle: TextStyle(fontSize: 15.0)),
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              // color: Colors.blue,
              child: Text(
                LocaleKeys.Pay.tr(),
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                openCheckout();
              },
            )
          ],
        ),
      ),
    );
  }
}
