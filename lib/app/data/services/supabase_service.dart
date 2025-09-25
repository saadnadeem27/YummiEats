import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/config/supabase_config.dart';
import '../models/restaurant.dart';
import '../models/category.dart';

class SupabaseService {
  static final _client = SupabaseConfig.client;

  // Authentication Services

  /// Sign up with email and password
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? userData,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: userData,
      );

      // Create user profile in users table
      if (response.user != null) {
        await _createUserProfile(response.user!, userData);
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Sign in with email and password
  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Sign in with Google
  static Future<bool> signInWithGoogle() async {
    try {
      await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.yummieats://login-callback/',
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Sign out
  static Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// Get current user
  static User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  /// Create user profile in database
  static Future<void> _createUserProfile(
      User user, Map<String, dynamic>? userData) async {
    final profile = {
      'id': user.id,
      'email': user.email,
      'full_name': userData?['full_name'] ?? '',
      'avatar_url': user.userMetadata?['avatar_url'] ?? '',
      'phone': userData?['phone'] ?? '',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    await _client.from(SupabaseConfig.usersTable).insert(profile);
  }

  // User Profile Services

  /// Get user profile
  static Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final response = await _client
          .from(SupabaseConfig.usersTable)
          .select()
          .eq('id', userId)
          .single();

      return response;
    } catch (e) {
      return null;
    }
  }

  /// Update user profile
  static Future<bool> updateUserProfile(
      String userId, Map<String, dynamic> updates) async {
    try {
      updates['updated_at'] = DateTime.now().toIso8601String();

      await _client
          .from(SupabaseConfig.usersTable)
          .update(updates)
          .eq('id', userId);

      return true;
    } catch (e) {
      return false;
    }
  }

  // Restaurant Services

  /// Get all restaurants
  static Future<List<Restaurant>> getRestaurants() async {
    try {
      final response = await _client
          .from(SupabaseConfig.restaurantsTable)
          .select('*')
          .order('rating', ascending: false);

      return (response as List)
          .map((json) => Restaurant.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Get restaurant by ID
  static Future<Restaurant?> getRestaurantById(String id) async {
    try {
      final response = await _client
          .from(SupabaseConfig.restaurantsTable)
          .select('*')
          .eq('id', id)
          .single();

      return Restaurant.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  /// Search restaurants
  static Future<List<Restaurant>> searchRestaurants(String query) async {
    try {
      final response = await _client
          .from(SupabaseConfig.restaurantsTable)
          .select('*')
          .or('name.ilike.%$query%,cuisine.ilike.%$query%,description.ilike.%$query%')
          .order('rating', ascending: false);

      return (response as List)
          .map((json) => Restaurant.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Category Services

  /// Get all categories
  static Future<List<Category>> getCategories() async {
    try {
      final response = await _client
          .from(SupabaseConfig.categoriesTable)
          .select('*')
          .order('name', ascending: true);

      return (response as List).map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Get restaurants by category
  static Future<List<Restaurant>> getRestaurantsByCategory(
      String categoryId) async {
    try {
      final response = await _client
          .from(SupabaseConfig.restaurantsTable)
          .select('*')
          .contains('category_ids', [categoryId]).order('rating',
              ascending: false);

      return (response as List)
          .map((json) => Restaurant.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Favorites Services

  /// Add restaurant to favorites
  static Future<bool> addToFavorites(String userId, String restaurantId) async {
    try {
      await _client.from(SupabaseConfig.favoritesTable).insert({
        'user_id': userId,
        'restaurant_id': restaurantId,
        'created_at': DateTime.now().toIso8601String(),
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Remove restaurant from favorites
  static Future<bool> removeFromFavorites(
      String userId, String restaurantId) async {
    try {
      await _client
          .from(SupabaseConfig.favoritesTable)
          .delete()
          .eq('user_id', userId)
          .eq('restaurant_id', restaurantId);

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get user favorites
  static Future<List<Restaurant>> getUserFavorites(String userId) async {
    try {
      final response = await _client
          .from(SupabaseConfig.favoritesTable)
          .select('restaurant_id, ${SupabaseConfig.restaurantsTable}(*)')
          .eq('user_id', userId);

      return (response as List)
          .map((item) =>
              Restaurant.fromJson(item[SupabaseConfig.restaurantsTable]))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Check if restaurant is favorite
  static Future<bool> isRestaurantFavorite(
      String userId, String restaurantId) async {
    try {
      final response = await _client
          .from(SupabaseConfig.favoritesTable)
          .select('id')
          .eq('user_id', userId)
          .eq('restaurant_id', restaurantId)
          .maybeSingle();

      return response != null;
    } catch (e) {
      return false;
    }
  }

  // Order Services

  /// Create order
  static Future<String?> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await _client
          .from(SupabaseConfig.ordersTable)
          .insert(orderData)
          .select('id')
          .single();

      return response['id'] as String;
    } catch (e) {
      return null;
    }
  }

  /// Get user orders
  static Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    try {
      final response = await _client
          .from(SupabaseConfig.ordersTable)
          .select('*, ${SupabaseConfig.restaurantsTable}(*)')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  // Address Services

  /// Add user address
  static Future<bool> addUserAddress(
      String userId, Map<String, dynamic> addressData) async {
    try {
      addressData['user_id'] = userId;
      addressData['created_at'] = DateTime.now().toIso8601String();

      await _client.from(SupabaseConfig.addressesTable).insert(addressData);

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get user addresses
  static Future<List<Map<String, dynamic>>> getUserAddresses(
      String userId) async {
    try {
      final response = await _client
          .from(SupabaseConfig.addressesTable)
          .select('*')
          .eq('user_id', userId)
          .order('is_default', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  // Real-time Services

  /// Listen to order status changes
  static RealtimeChannel listenToOrderUpdates(
      String orderId, Function(Map<String, dynamic>) onUpdate) {
    return _client
        .channel('order_updates_$orderId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: SupabaseConfig.ordersTable,
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: orderId,
          ),
          callback: (payload) {
            onUpdate(payload.newRecord);
          },
        )
        .subscribe();
  }

  /// Upload image to Supabase Storage
  static Future<String?> uploadImage(
      String bucketName, String filePath, Uint8List fileBytes) async {
    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${filePath.split('/').last}';

      await _client.storage.from(bucketName).uploadBinary(fileName, fileBytes);

      final publicUrl = _client.storage.from(bucketName).getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      return null;
    }
  }

  /// Delete image from Supabase Storage
  static Future<bool> deleteImage(String bucketName, String fileName) async {
    try {
      await _client.storage.from(bucketName).remove([fileName]);

      return true;
    } catch (e) {
      return false;
    }
  }
}
