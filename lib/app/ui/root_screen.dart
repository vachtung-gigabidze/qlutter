// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:qlutter/app/ui/app_loader.dart';
// import 'package:qlutter/feature/internet_activity/internet_cubit.dart';
// // import 'package:qlutter/constants.dart';

// class RootScreen extends StatelessWidget {
//   const RootScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
//         builder: (context, state) {
//       return RecipeListBuilder(
//         isEmpty: (context) => Scaffold(
//           body: Center(
//               child: state.connected
//                   ? const Text('Не данных')
//                   : const Text('Не соединения с интернетом')),
//           backgroundColor: AppColors.accent,
//         ),
//         isWaiting: (context) => const AppLoader(),
//         isLoaded: (context, value, child) => RecipesListScreen(
//           recipes: value,
//           isInternetConnectivity: state.connected,
//         ),
//       );
//     });
//   }
// }

