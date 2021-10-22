import 'dart:async';

import 'package:at_chat_flutter/services/chat_service.dart';
import 'package:at_chat_flutter/utils/init_chat_service.dart';
import 'package:at_contacts_flutter/utils/init_contacts_service.dart';
import 'package:chit_chat_runtime_live/onboarding_button.dart';
import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:at_utils/at_logger.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:at_app_flutter/at_app_flutter.dart';

import 'contact_screen.dart';

void main() {
  AtEnv.load();
  runApp(const MyApp());
}

Future<AtClientPreference> loadAtClientPreference() async {
  var dir = await path_provider.getApplicationSupportDirectory();
  return AtClientPreference()
        ..rootDomain = AtEnv.rootDomain
        ..namespace = AtEnv.appNamespace
        ..hiveStoragePath = dir.path
        ..commitLogPath = dir.path
        ..isLocalStoreRequired = true
      // TODO set the rest of your AtClientPreference here
      ;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // * load the AtClientPreference in the background
  Future<AtClientPreference> futurePreference = loadAtClientPreference();

  AtClientPreference? atClientPreference;

  final AtSignLogger _logger = AtSignLogger(AtEnv.appNamespace);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // * The onboarding screen (first screen)
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MyApp'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: Column(
              children: [
                const Text('Chit Ch@t', style: TextStyle(fontSize: 36)),
                const SizedBox(height: 100),
                OnboardingButton((String? _atsign) async {
                  atClientPreference = await futurePreference;
                  Onboarding(
                    atsign: _atsign,
                    context: context,
                    atClientPreference: atClientPreference!,
                    domain: AtEnv.rootDomain,
                    rootEnvironment: AtEnv.rootEnvironment,
                    onboard: (value, atsign) {
                      initializeContactsService(rootDomain: AtEnv.rootDomain);
                      initializeChatService(
                        AtClientManager.getInstance(),
                        atsign!,
                        rootDomain: AtEnv.rootDomain,
                      );

                      _logger.finer('Successfully onboarded $atsign');
                    },
                    onError: (error) {
                      _logger.severe('Onboarding throws $error error');
                    },
                    nextScreen: const ContactScreen(),
                    appAPIKey: AtEnv.appApiKey,
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
