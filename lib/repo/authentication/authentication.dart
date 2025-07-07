import 'package:halaqat_wasl_driver_app/model/driver%20model/driver_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Authentication {
  final SupabaseClient client = Supabase.instance.client;

  Future<(User?, DriverModel?)> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final authResponse = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = authResponse.user;
      if (user == null) return (null, null);

      final driverResponse = await client
          .from('driver')
          .select()
          .eq('driver_id', user.id)
          .maybeSingle();
      if (driverResponse == null) return (user, null);

      final driver = DriverModelMapper.fromMap(driverResponse);
      return (user, driver);
    } catch (e) {
      return (null, null);
    }
  }

  Future<DriverModel?> fetchDriver() async {
    final driver = client.auth.currentUser;
    if (driver == null) return null;

    final driverResponse = await client
        .from('driver')
        .select()
        .eq('driver_id', driver.id)
        .maybeSingle();

    if (driverResponse == null) return null;

    return DriverModelMapper.fromMap(driverResponse);
  }
}
