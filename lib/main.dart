import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/account_viewmodel.dart';
import 'package:flutter_firebase_chat/viewmodels/chat_detail_viewmodel.dart';
import 'package:flutter_firebase_chat/viewmodels/chat_viewmodel.dart';
import 'package:flutter_firebase_chat/viewmodels/control_viewmodel.dart';
import 'package:flutter_firebase_chat/viewmodels/home_viewmodel.dart';
import 'package:flutter_firebase_chat/views/control_view.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatDetailViewModel()),
        ChangeNotifierProvider(create: (_) => AccountViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(create: (_) => ControlViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ControlView(),
      ),
    ),
  );
}
