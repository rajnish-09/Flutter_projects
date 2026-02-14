import 'dart:io';

import 'package:ecommerce_app/service/khalti_service.dart';
import 'package:flutter/material.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';

class KhaltiDemo extends StatefulWidget {
  const KhaltiDemo({super.key});

  @override
  State<KhaltiDemo> createState() => _KhaltiDemoState();
}

class _KhaltiDemoState extends State<KhaltiDemo> {
  Future<Khalti>? khalti;
  PaymentResult? paymentResult;
  KhaltiServicePidx khaltiService = KhaltiServicePidx();
  String? pidx;

  // String pidx = 'ZyzCEMLFz2QYFYfERGh8LE';

  Future<String> getPidx() async {
    final fetchedPidx = await khaltiService.getPidxFromKhalti();
    return fetchedPidx;
  }

  @override
  void initState() {
    super.initState();
    // fetchPidxAndInitKhalti();
  }

  Future<void> fetchPidxAndInitKhalti() async {
    // 1️⃣ Fetch pidx from backend
    final fetchedPidx = await khaltiService.getPidxFromKhalti();

    // 2️⃣ Save in state
    setState(() {
      pidx = fetchedPidx;
    });

    // 3️⃣ Initialize Khalti with the real pidx
    final payConfig = KhaltiPayConfig(
      publicKey: '04eb46c5c31442ed978b3d5ef92b471f', // use test for testing
      pidx: pidx!,
      environment: Environment.test,
    );

    khalti = Khalti.init(
      payConfig: payConfig,
      enableDebugging: true,
      onPaymentResult: (result, khaltiInstance) {
        setState(() {
          paymentResult = result;
        });
        khaltiInstance.close(context);
      },
      onMessage:
          (
            khaltiInstance, {
            description,
            statusCode,
            event,
            needsPaymentConfirmation,
          }) {
            khaltiInstance.close(context);
          },
      onReturn: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: FutureBuilder(
      //     future: khalti,
      //     initialData: null,
      //     builder: (context, snapshot) {
      //       final khaltiSnapshot = snapshot.data;
      //       if (khaltiSnapshot == null) {
      //         return const CircularProgressIndicator.adaptive();
      //       }
      //       return Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           // Image.asset('assets/seru.png', height: 200, width: 200),
      //           // const SizedBox(height: 120),
      //           // const Text('Rs. 22', style: TextStyle(fontSize: 25)),
      //           // const Text('1 day fee'),
      //           ElevatedButton(
      //             onPressed: () {
      //               getPidx();
      //               print(pidx);
      //             },
      //             child: Text("data"),
      //           ),
      //           OutlinedButton(
      //             onPressed: () => khaltiSnapshot.open(context),
      //             child: const Text('Pay with Khalti'),
      //           ),
      //           const SizedBox(height: 120),
      //           paymentResult == null
      //               ? Text('pidx: $pidx', style: const TextStyle(fontSize: 15))
      //               : Column(
      //                   children: [
      //                     Text('pidx: ${paymentResult!.payload?.pidx}'),

      //                     Text(
      //                       'Transaction ID: ${paymentResult!.payload?.transactionId}',
      //                     ),
      //                   ],
      //                 ),
      //           const SizedBox(height: 120),
      //         ],
      //       );
      //     },
      //   ),
      // ),
      body: SafeArea(child: Text(pidx ?? 'sdf')),
    );
  }
}
