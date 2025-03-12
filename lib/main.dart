import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app/app.dart';
import 'app/core/local_storage/app_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // for initializing local storage
  final appStorage = AppStorage();
  await appStorage.initAppStorage();
  await dotenv.load(fileName: ".env");

  // test Key = 'pk_test_xEvkQAYbKoJv9fNOCPnih5Rh00exMSMgy8';
  Stripe.publishableKey = 'pk_live_KhACjhma0Ui3fnqeKotp4kUL00wVD1cZRS';
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  runApp(
    ProviderScope(
      overrides: [
        appStorageProvider.overrideWithValue(appStorage),
      ],
      child: const App(),
    ),
  );
}
