import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/data/firebase_auth_repo.dart';
import 'package:social_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_app/features/auth/presentation/pages/auth_page.dart';
import 'package:social_app/features/post/presentation/pages/home._page.dart';
import 'features/auth/presentation/cubits/auth_states.dart';
import 'themes/light_mode.dart';

/*

APP - Root Level

------------------------------------------------------------------

Repositories: for the database
- firebase

Bloc Providers for state management
- auth
- profile
- home
- search
- theme

Check Auth State
- unauthenticated -> auth page (login/register)
- authenticated -> home page
 */

class MyApp extends StatelessWidget {

  // auth repo
  final authRepo = FirebaseAuthRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // provide cubit to app
    return BlocProvider(create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);

            // unauthenticated -> auth page (login/register)
            if (authState is Unauthenticated) {
              return const AuthPage();
            }

            // authenticated -> home page
            if (authState is Authenticated) {
              return const HomePage();
            }

            // loading..
            else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          // listen for errors..
          listener:  (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          }
          ),
    ),
    );
  }
}

