// import 'package:flutter/material.dart';
// import 'package:whip_up/Screens/GetStarted/presentation/get_started_screen.dart';
// import 'package:whip_up/Screens/home/presentation/home_screen.dart';
// import 'app_route_name.dart';

// class AppRoute {
//   static Route<dynamic>? generate(RouteSettings settings) {
//     switch (settings.name) {
//       case AppRouteName.getStarted:
//         return MaterialPageRoute(
//           builder: (_) => const GetStartedScreen(),
//           settings: settings,
//         );

//       case AppRouteName.home:
//         return PageRouteBuilder(
//           settings: settings,
//           pageBuilder: (_, __, ___) => const HomeScrenn(),
//           transitionDuration: const Duration(milliseconds: 400),
//           transitionsBuilder: (_, animation, __, child) {
//             return SlideTransition(
//               position: Tween<Offset>(
//                 begin: const Offset(1, 0),
//                 end: Offset.zero,
//               ).animate(animation),
//               child: child,
//             );
//           },
//         );
//     }

//     return null;
//   }
// }
