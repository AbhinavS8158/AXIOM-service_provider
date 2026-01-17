import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/chatlist/chatlist.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.forgot.withOpacity(0.1),
            AppColor.forgot.withOpacity(0.05),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopRow(context),
            const SizedBox(height: 24),
            _buildWelcomeCard(),
          ],
        ),
      ),
    );
  }

  // ---------------- TOP ROW ----------------
  Widget _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBranding(),
        _buildChatButton(context),
      ],
    );
  }

  // ---------------- BRANDING ----------------
  Widget _buildBranding() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AXIOM',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColor.forgot,
            letterSpacing: 1.2,
          ),
        ),
        Text(
          'Property Management',
          style: TextStyle(
            fontSize: 14,
            color: AppColor.forgot.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ---------------- CHAT BUTTON ----------------
  Widget _buildChatButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;

        if (currentUserId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not logged in')),
          );
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatListScreen(currentUserId: currentUserId),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColor.blk.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.chat_bubble_outline,
          color: AppColor.forgot,
          size: 24,
        ),
      ),
    );
  }

  // ---------------- WELCOME CARD ----------------
  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.forgot.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.waving_hand,
            color: AppColor.amber,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.forgot,
                  ),
                ),
                Text(
                  'Manage your properties efficiently',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
