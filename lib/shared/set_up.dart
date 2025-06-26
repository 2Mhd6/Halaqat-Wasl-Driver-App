

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SetupSupabase {
  static final Supabase sharedSupabase = Supabase.instance;

  static Future<void> setUpSupabase() {
    return Supabase.initialize(
      url: dotenv.get('supabase_url'),
      anonKey: dotenv.get('supabase_key'),
    );
  }
}
