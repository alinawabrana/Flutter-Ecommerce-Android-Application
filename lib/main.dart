import 'package:e_commerce_app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';

/// -----------ENTRY PoINT OF FLUTTER APP------------
Future<void> main() async {
  // Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding
      .ensureInitialized(); // Imp for firebase initialization

  await _setupStripe();

  // Init GetX Local Storage
  await GetStorage.init();

  // Await Native Flash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase & Authentication Repository

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) =>
      Get.put(AuthenticationRepository())); // Imp for firebase initialization

  runApp(const App());
}

Future<void> _setupStripe() async {
  Stripe.publishableKey =
      "pk_test_51RJHTHH0MmeH7QGkfcrQGpfwxy2Sev2vZACC3dTYD2N7Q3DpXwQLXyMGkr4cJFUMZmCMrCPvyYOhQEBjyHIWHtUX00VYic1gf0";
  await Stripe.instance.applySettings(); // ✅ Required
}
