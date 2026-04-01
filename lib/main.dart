import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/features/auth/views/sendotp_page.dart';
import 'package:task/features/home/models/user_model.dart';
import 'package:task/features/home/viewmodel/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive Adapters
  Hive.registerAdapter(UserModelAdapter());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..initializeHive(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SendotpPage(),
      ),
    );
  }
}

