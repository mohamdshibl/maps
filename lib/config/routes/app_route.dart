// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maps/config/routes/routes.dart';
//
// import '../../features/login/login.dart';
//
// class AppRoutes {
//   static Route? onGenerate(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case Routes.login:
//         return MaterialPageRoute(
//           builder: (context) => BlocProvider(
//             //create: (context) => LoginCubit(loginUseCase: getIt()),
//             create: (BuildContext context) {  },
//             child: LoginScreen(),
//           ),
//         );
//
//       case Routes.map:
//         return MaterialPageRoute(
//           builder: (context) => BlocProvider(
//             create: (context) =>
//             //HomeCubit(networkInfo: getIt())..listenToNetworkConnection(),
//             child: const map(),
//           ),
//         );
//
//       default:
//         return null;
//     }
//   }
// }
