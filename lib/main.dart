import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'account/register/register_page.dart';
import 'chat/chat_page.dart';
import 'common/chat_service.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    return Provider<ChatService>(
      create: (_) => SupabaseChatService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Chat App',
        theme: theme,
        home: session == null ? RegisterPage() : ChatPage(),
      ),
    );
  }
}
