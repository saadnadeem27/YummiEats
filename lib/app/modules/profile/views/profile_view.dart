import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: controller.updateProfile,
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            children: [
              // Profile Header
              AnimationConfiguration.staggeredList(
                position: 0,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildProfileHeader(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Menu Items
              ...List.generate(_menuItems.length, (index) {
                return AnimationConfiguration.staggeredList(
                  position: index + 1,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildMenuItem(_menuItems[index]),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Logout Button
              AnimationConfiguration.staggeredList(
                position: _menuItems.length + 1,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildLogoutButton(),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Obx(() => Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(controller.userAvatar.value),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.userName.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.userEmail.value,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      controller.userPhone.value,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (item.subtitle != null)
                        Text(
                          item.subtitle!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
                if (item.trailing != null)
                  item.trailing!
                else
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.logout,
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  List<MenuItem> get _menuItems => [
        MenuItem(
          icon: Icons.receipt_long,
          title: 'Order History',
          subtitle: 'View your past orders',
          color: Colors.blue,
          onTap: controller.viewOrderHistory,
        ),
        MenuItem(
          icon: Icons.favorite,
          title: 'Favorites',
          subtitle: 'Your favorite restaurants',
          color: Colors.red,
          onTap: controller.viewFavorites,
        ),
        MenuItem(
          icon: Icons.location_on,
          title: 'Addresses',
          subtitle: 'Manage delivery addresses',
          color: Colors.green,
          onTap: controller.manageAddresses,
        ),
        MenuItem(
          icon: Icons.payment,
          title: 'Payment Methods',
          subtitle: 'Cards and payment options',
          color: Colors.orange,
          onTap: controller.managePaymentMethods,
        ),
        MenuItem(
          icon: Icons.notifications,
          title: 'Notifications',
          subtitle: 'Push notification settings',
          color: Colors.purple,
          trailing: Obx(() => Switch(
                value: controller.notificationsEnabled.value,
                onChanged: (value) =>
                    controller.notificationsEnabled.value = value,
                activeColor: AppColors.primary,
              )),
          onTap: () {},
        ),
        MenuItem(
          icon: Icons.location_searching,
          title: 'Location Services',
          subtitle: 'Allow location access',
          color: Colors.teal,
          trailing: Obx(() => Switch(
                value: controller.locationEnabled.value,
                onChanged: (value) => controller.locationEnabled.value = value,
                activeColor: AppColors.primary,
              )),
          onTap: () {},
        ),
        MenuItem(
          icon: Icons.dark_mode,
          title: 'Dark Mode',
          subtitle: 'Switch to dark theme',
          color: Colors.indigo,
          trailing: Obx(() => Switch(
                value: controller.darkModeEnabled.value,
                onChanged: (value) => controller.darkModeEnabled.value = value,
                activeColor: AppColors.primary,
              )),
          onTap: () {},
        ),
        MenuItem(
          icon: Icons.lock,
          title: 'Change Password',
          subtitle: 'Update your password',
          color: Colors.brown,
          onTap: controller.changePassword,
        ),
        MenuItem(
          icon: Icons.support_agent,
          title: 'Support',
          subtitle: 'Get help and support',
          color: Colors.cyan,
          onTap: controller.contactSupport,
        ),
        MenuItem(
          icon: Icons.star_rate,
          title: 'Rate App',
          subtitle: 'Rate us on app store',
          color: Colors.amber,
          onTap: controller.rateApp,
        ),
        MenuItem(
          icon: Icons.share,
          title: 'Share App',
          subtitle: 'Share with friends',
          color: Colors.lightGreen,
          onTap: controller.shareApp,
        ),
        MenuItem(
          icon: Icons.description,
          title: 'Terms & Conditions',
          subtitle: 'Read our terms',
          color: Colors.grey,
          onTap: controller.viewTermsAndConditions,
        ),
        MenuItem(
          icon: Icons.privacy_tip,
          title: 'Privacy Policy',
          subtitle: 'Read our privacy policy',
          color: Colors.blueGrey,
          onTap: controller.viewPrivacyPolicy,
        ),
      ];
}

class MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color color;
  final VoidCallback onTap;
  final Widget? trailing;

  MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.color,
    required this.onTap,
    this.trailing,
  });
}
