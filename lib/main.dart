import 'package:aplikasi_kepegawaian/pages/home_page.dart';
import 'package:aplikasi_kepegawaian/pages/login/register_page.dart';
import 'package:aplikasi_kepegawaian/pages/login/profile_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/pegawai_page.dart';
import 'package:aplikasi_kepegawaian/pages/sppd/sppd_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/create_spt_page.dart';
import 'package:aplikasi_kepegawaian/pages/login/login_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/report_spt.dart';
import 'package:aplikasi_kepegawaian/pages/spt/spt_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login',
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      // theme: ThemeData(scaffoldBackgroundColor: Colors.grey),
      supportedLocales: [Locale('id')],
      home: SppdPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
