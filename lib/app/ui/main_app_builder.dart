import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qlutter/app/di/init_di.dart';
import 'package:qlutter/app/domain/app_builder.dart';
import 'package:qlutter/app/ui/app_loader.dart';
import 'package:qlutter/app/ui/root_screen.dart';
import 'package:qlutter/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:qlutter/feature/auth/ui/components/auth_builder.dart';
import 'package:qlutter/feature/auth/ui/auth_screen.dart';
import 'package:qlutter/feature/favorite/ui/favorites_screen.dart';
import 'package:qlutter/feature/freezer/domain/state/cubit/freezer_cubit.dart';
import 'package:qlutter/feature/freezer/freezer_repository.dart';
import 'package:qlutter/feature/freezer/ui/freezer_screen.dart';
import 'package:qlutter/feature/internet/domain/internet_state/internet_cubit.dart';
import 'package:qlutter/feature/logo/logo_screen.dart';
import 'package:qlutter/feature/navbar/domain/navbar_state/navbar_cubit.dart';
import 'package:qlutter/feature/navbar/ui/scaffold_with_bottom_navbar.dart';
import 'package:qlutter/feature/recipe_list/domain/recipe_list_repository.dart';
import 'package:qlutter/feature/recipe_list/domain/recipe_list_state/recipe_list_cubit.dart';
import 'package:qlutter/feature/auth/ui/profile_screen.dart';

class MainAppBuilder implements AppBuilder {
  final _routes = GoRouter(
    initialLocation: '/logo',
    routes: [
      GoRoute(
          path: '/logo',
          builder: (context, state) => const LogoScreen(nextRoute: '/')),
      ShellRoute(
          builder: (context, state, child) => ScaffoldWithBottomNavBar(
                child: child,
              ),
          routes: [
            GoRoute(
                path: '/auth',
                builder: (context, state) => AuthBuilder(
                      isNotAuthorized: (context) => AuthScreen(),
                      isWaiting: (context) => const AppLoader(),
                      isAuthorized: (context, value, child) =>
                          const ProfileScreen(),
                    )),
            GoRoute(
                path: '/profile',
                builder: (context, state) => AuthBuilder(
                      isNotAuthorized: (context) => AuthScreen(),
                      isWaiting: (context) => const AppLoader(),
                      isAuthorized: (context, value, child) =>
                          const ProfileScreen(),
                    )),
            GoRoute(
                path: '/favorites',
                builder: (context, state) => const FavoritesScreen()),
            GoRoute(
                name: "root",
                path: '/',
                builder: (context, state) => const RootScreen()),
            GoRoute(
                path: '/favorites',
                builder: (context, state) => const FavoritesScreen()),
            GoRoute(
                path: '/freezer',
                builder: (context, state) => const FreezerScreen()),
          ])
    ],
  );

  @override
  Widget buildApp() {
    return _GlobalProviders(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Otus Food App',
        routerConfig: _routes,
      ),
    );
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetConnectionCubit(),
        ),
        BlocProvider(
          create: (context) =>
              locator.get<AuthCubit>(), //AuthCubit(locator<AuthRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              RecipeListCubit(locator<RecipeListRepository>())..getRecipeList(),
        ),
        BlocProvider(
          create: (context) =>
              FreezerCubit(locator<FreezerRepository>())..fetchFreezer(),
        ),
        BlocProvider(create: (context) => NavbarCubit()),
      ],
      child: child,
    );
  }
}
