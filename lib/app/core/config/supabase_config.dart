import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // Supabase Configuration
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // Initialize Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
      realtimeClientOptions: const RealtimeClientOptions(
        logLevel: RealtimeLogLevel.info,
      ),
      storageOptions: const StorageClientOptions(
        retryAttempts: 10,
      ),
    );
  }

  // Get Supabase client instance
  static SupabaseClient get client => Supabase.instance.client;

  // Get Auth instance
  static GoTrueClient get auth => client.auth;

  // Get Storage instance
  static SupabaseStorageClient get storage => client.storage;

  // Get Realtime instance
  static RealtimeClient get realtime => client.realtime;

  // Database table names
  static const String usersTable = 'users';
  static const String restaurantsTable = 'restaurants';
  static const String categoriesTable = 'categories';
  static const String menuItemsTable = 'menu_items';
  static const String ordersTable = 'orders';
  static const String orderItemsTable = 'order_items';
  static const String reviewsTable = 'reviews';
  static const String favoritesTable = 'favorites';
  static const String cartTable = 'cart';
  static const String addressesTable = 'addresses';
}
