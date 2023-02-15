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
//           .collection('golongan')
//           .add({'nama_golongan': nama});
//     } catch (e) {}
//   }

//   List pangkat = [
//     "Juru Muda / I a",
//     "Juru Muda Tingkat / I b",
//     "Juru / I c",
//     "Juru Tingkat I / I d",
//     "Pengatur Muda / II a",
//     "Pengatur Muda Tingkat I / II b",
//     "Pengatur / II c",
//     "Pengatur Tingkat I / II d",
//     "Penata Muda / III a",
//     "Penata Muda Tingkat I / III b",
//     "Penata / III c",
//     "Penata Tingkat I / III d",
//     "Pembina / IV a",
//     "Pembina Tingkat I / IV b",
//     "Pembina Muda / IV c",
//     "Pembina Madya / IV d",
//     "Pembina Utama / IV e",
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
