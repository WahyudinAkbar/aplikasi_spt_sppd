import 'package:aplikasi_kepegawaian/constant.dart';
import 'package:aplikasi_kepegawaian/pages/anggaran/anggaran_page.dart';
import 'package:aplikasi_kepegawaian/pages/anggaran/create_anggaran_page.dart';
import 'package:aplikasi_kepegawaian/pages/homepage/home_page.dart';
import 'package:aplikasi_kepegawaian/pages/homepage/home_page_user.dart';
import 'package:aplikasi_kepegawaian/pages/kegiatan/create_kegiatan_page.dart';
import 'package:aplikasi_kepegawaian/pages/kegiatan/kegiatan_page.dart';
import 'package:aplikasi_kepegawaian/pages/kegiatan/tes.dart';
import 'package:aplikasi_kepegawaian/pages/kuitansi/kuitansi_page.dart';
import 'package:aplikasi_kepegawaian/pages/login/login_page.dart';
import 'package:aplikasi_kepegawaian/pages/login/profile_page.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/show_photo_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/pegawai_page.dart';
import 'package:aplikasi_kepegawaian/pages/pengeluaran/create_pengeluaran_page.dart';
import 'package:aplikasi_kepegawaian/pages/pengeluaran/pengeluaran_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/spt_page.dart';
import 'package:aplikasi_kepegawaian/tes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    return MaterialApp(
      title: 'Login',
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      // theme: ThemeData(scaffoldBackgroundColor: Colors.grey),
      supportedLocales: const [Locale('id')],
      home: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.data?.data() != null) {
              if (snapshot.data?.get('roles') == 'admin') {
                return const PengeluaranPage();
              } else if (snapshot.data?.get('roles') == 'user') {
                return const HomePageUser();
              }
            } else {
              return const LoginPage();
            }
            return const Center(child: CircularProgressIndicator());
          })),
      debugShowCheckedModeBanner: false,
    );
  }
}
