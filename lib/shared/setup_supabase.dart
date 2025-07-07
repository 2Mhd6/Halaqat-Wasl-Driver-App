// lib/shared/set_up.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class SetupSupabase {
  static late final SupabaseClient _client;

  /// Initialize Supabase and store client
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: dotenv.get('supabase_url'),
      anonKey: dotenv.get('supabase_key'),
  debug: true,
  realtimeClientOptions: const RealtimeClientOptions(
    logLevel: RealtimeLogLevel.info,
    timeout: Duration(seconds: 5),
  ),
);
    _client = Supabase.instance.client;
  }

  /// Get Supabase client instance
  static SupabaseClient get client {
    try {
      return _client;
    } catch (_) {
      throw Exception(
        'Supabase not initialized. Call SetupSupabase.initialize() first',
      );
    }
  }

  /// Get Supabase client instance

  /// Get current session (null if not logged in)
  static Session? get currentSession => _client.auth.currentSession;

  /// Get current user (null if not logged in)
  static User? get currentUser => _client.auth.currentUser;

  /// Sign out
  static Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// Check if user is logged in
  static bool get isLoggedIn => currentUser != null;
}
