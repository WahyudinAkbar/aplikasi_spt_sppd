// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class Tes extends StatefulWidget {
//   const Tes({super.key});

//   @override
//   State<Tes> createState() => _TesState();
// }

// class _TesState extends State<Tes> {
//   void tambahPangkat(String nama) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('bidang')
//           .add({'nama_bidang': nama});
//     } catch (e) {}
//   }

//   List pangkat = [
//     "Komunikasi dan Informasi Publik",
//     "Persandian dan Statistik",
//     "Teknologi Informasi dan Komunikasi",
//     "Umum dan Kepegawaian",
//     "Keuangan",
//     "Perencanaan"
//   ];

//   @override
//   void initState() {
//     super.initState();

//     for (var i = 0; i < pangkat.length; i++) {
//       tambahPangkat(pangkat[i]);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }
