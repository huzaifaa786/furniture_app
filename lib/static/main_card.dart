// import 'package:flutter/material.dart';

// class MainStackCard extends StatelessWidget {
//   const MainStackCard({super.key,this.onNotiTap,this.onFavTap,this.onProfileTap,this.name});
//   final onNotiTap;
//   final onProfileTap;
//   final onFavTap;
//   final name;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.loose,
//       children: [
//         Container(
//           margin: EdgeInsets.only(bottom: 30),
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height * 0.25,
//           decoration: BoxDecoration(
//             color: Color(0xFF34607B),
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(25),
//                 bottomRight: Radius.circular(25)),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TopBar(
//                 onFavTap: onFavTap,
//                 onNotiTap: onNotiTap,
//                 onProfileTap: onProfileTap,
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.12,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Good Morning, ' + name,
//                       maxLines: 2,
//                       style: TextStyle(
//                           fontSize: 23,
//                           fontWeight: FontWeight.w600,
//                           color: white),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned.fill(
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => FreeItem_screen(),
//                     ));
//               },
//               child: Container(
//                 width: 280,
//                 height: 59,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.0824137),
//                       blurRadius: 15,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 85,
//                       ),
//                       Image.asset("assets/icons/free.png"),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child: Text(
//                           "Free Item",
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
