import 'package:e_com_app/features/home/home.dart';
import 'package:e_com_app/features/registration_login/registration_and_login_screen.dart';
import 'package:e_com_app/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_com_app/const/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: myOrange,
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      child: MaterialApp(
          theme: ThemeData().copyWith(
            colorScheme: kColorScheme,
            textTheme: const TextTheme().copyWith(
              displayLarge: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              displayMedium: const TextStyle(
                fontSize: 15,
              ),
              labelSmall: const TextStyle(
                color: Colors.black,
                fontSize: 11,
              ),
              labelMedium: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: myYellow,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ref.watch(userProvier.notifier).getUserData();
            return const Home();
          }
          return const RegistrationAndLoginScreen(registrationMode: false);
        },
      ),
    );
  }
}
