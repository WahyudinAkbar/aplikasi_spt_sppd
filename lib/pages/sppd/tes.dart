import 'package:aplikasi_kepegawaian/pages/sppd/report_sppd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: Text('Click'),
              onPressed: () {
                reportSppd(context);
              },
            ),
          ),
        ],
      )),
    );
  }
}
