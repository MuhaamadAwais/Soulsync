import 'package:faith/bottomnavi.dart';
import 'package:faith/dhikr_feature/presentation/provider/dhikrprovider.dart';
import 'package:faith/firebase_options.dart';
import 'package:faith/home_feature/presentation/provider/homeprovider.dart';
import 'package:faith/onboardscreens_feature/presentation/pages/firstpage.dart';
import 'package:faith/profile_feature/presentation/provider/nameprovider.dart';
import 'package:faith/profile_feature/presentation/provider/profileselectprovider.dart';
import 'package:faith/progress_feature/presentation/provider/progressprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Homeprovider()),
        ChangeNotifierProvider(create: (context) => Nameprovider()..loadData()),
        ChangeNotifierProvider(create: (context) => Progressprovider()),
        ChangeNotifierProvider(create: (context) => Dhikrprovider()),
        ChangeNotifierProvider(create: (context) => Profileselectprovider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: user != null ? const Bottomnavi() : const Firstpage(),
      ),
    );
  }
}
