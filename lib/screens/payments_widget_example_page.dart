import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jorim_flutter/screens/home_page.dart';
import 'package:jorim_flutter/util/logger.dart';
import 'dart:math';
import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';

class PaymentWidgetExamplePage extends StatefulWidget {
  const PaymentWidgetExamplePage({super.key});
  @override
  State<PaymentWidgetExamplePage> createState() {
    return _PaymentWidgetExamplePageState();
  }
}

class _PaymentWidgetExamplePageState extends State<PaymentWidgetExamplePage> {
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;
  @override
  void initState() {
    super.initState();
    _paymentWidget = PaymentWidget(
      clientKey: "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm",
      customerKey: "L_ggoVDhPrfm3R-fTDTsH",
    );
    _paymentWidget
        .renderPaymentMethods(
          selector: 'methods',
          amount: Amount(value: 3000, currency: Currency.KRW, country: "KR"),
          options: RenderPaymentMethodsOptions(variantKey: "DEFAULT"),
        )
        .then((control) {
          _paymentMethodWidgetControl = control;
        });
    _paymentWidget.renderAgreement(selector: 'agreement').then((control) {
      _agreementWidgetControl = control;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  PaymentMethodWidget(
                    paymentWidget: _paymentWidget,
                    selector: 'methods',
                  ),
                  AgreementWidget(
                    paymentWidget: _paymentWidget,
                    selector: 'agreement',
                  ),
                  ElevatedButton(
                    onPressed: payResult,
                    child: const Text("결제하기"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedPaymentMethod =
                          await _paymentMethodWidgetControl
                              ?.getSelectedPaymentMethod();
                      logMessage(
                        '${selectedPaymentMethod?.method} ${selectedPaymentMethod?.easyPay?.provider ?? ''}',
                      );
                    },
                    child: const Text('선택한 결제수단 출력'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final agreementStatus =
                          await _agreementWidgetControl?.getAgreementStatus();
                      logMessage('${agreementStatus?.agreedRequiredTerms}');
                    },
                    child: const Text('약관 동의 상태 출력'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _paymentMethodWidgetControl?.updateAmount(
                        amount: 300,
                      );
                      logMessage('결제 금액이 300원으로 변경되었습니다.');
                    },
                    child: const Text('결제 금액 변경'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void payResult() async {
    //final String orderId = generateOrderId();
    final paymentResult = await _paymentWidget.requestPayment(
      paymentInfo: const PaymentInfo(
        orderId: 'OfHi6WT2Q8WEb-M81QDdt', //분명컨데 여기서 문제 생길 수 있음
        orderName: "Toss shirts",
      ),
    );
    if (paymentResult.success != null) {
      logMessage("결제 성공", level: LogLevel.INFO);
      Fluttertoast.showToast(
        msg: "결제가 성공적으로 진행되었습니다",
        toastLength: Toast.LENGTH_LONG,
        fontSize: 16.0,
      );
      goToHome();
    } else if (paymentResult.fail != null) {
      logMessage("결제 실패", level: LogLevel.ERROR);
    }
  }

  String generateOrderId() {
    const String allowedChars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
    const int length = 64;
    final Random random = Random.secure();

    return List.generate(
      length,
      (index) => allowedChars[random.nextInt(allowedChars.length)],
    ).join();
  }

  void goToHome() {
    logMessage("로그인화면으로 이동", level: LogLevel.INFO);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
