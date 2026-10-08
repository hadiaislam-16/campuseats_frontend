import 'package:flutter/material.dart';
import 'student_auth_screen.dart';

import '../theme/app_theme.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() =>
      _RoleSelectionScreenState();
}

class _RoleSelectionScreenState
    extends State<RoleSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                children: [
                  const Spacer(),

                  _buildBrandMark(),

                  const SizedBox(height: 30),

                  const Text(
                    'How will you\nuse Campus Eats?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      height: 1.05,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w800,
                      color: AppColors.forest,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Choose your role to get started.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.muted,
                    ),
                  ),

                  const SizedBox(height: 38),

                  _buildRoleButton(
                    icon: Icons.school_rounded,
                    title: 'I’m a Student',
                    subtitle: 'Discover food & place orders',
                    onTap: _studentSelected,
                    filled: true,
                  ),

                  const SizedBox(height: 14),

                  _buildRoleButton(
                    icon: Icons.storefront_rounded,
                    title: 'I’m a Vendor',
                    subtitle: 'Manage your menu & orders',
                    onTap: _vendorSelected,
                  ),

                  const SizedBox(height: 14),

                  _buildRoleButton(
                    icon: Icons.delivery_dining_rounded,
                    title: 'I’m a Runner',
                    subtitle: 'Deliver campus food orders',
                    onTap: _runnerSelected,
                  ),

                  const Spacer(),

                  const Text(
                    'CAMPUS EATS',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      color: AppColors.terracotta,
                    ),
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandMark() {
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.forest.withValues(
              alpha: 0.12,
            ),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.restaurant_rounded,
            size: 29,
            color: AppColors.cream,
          ),
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: AppColors.terracotta,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool filled = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: filled
                ? AppColors.forest
                : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: filled
                  ? AppColors.forest
                  : const Color(0xFFE7E1D8),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: filled
                      ? AppColors.white.withValues(
                          alpha: 0.12,
                        )
                      : AppColors.cream,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  size: 23,
                  color: filled
                      ? AppColors.peach
                      : AppColors.forest,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: filled
                            ? AppColors.white
                            : AppColors.charcoal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: filled
                            ? AppColors.cream.withValues(
                                alpha: 0.72,
                              )
                            : AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: filled
                    ? AppColors.peach
                    : AppColors.sage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _studentSelected() {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (_, __, ___) =>
          const StudentAuthScreen(),
      transitionDuration:
          const Duration(milliseconds: 700),
      reverseTransitionDuration:
          const Duration(milliseconds: 500),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
    ),
  );
}

  void _vendorSelected() {
    _showComingNext('Vendor authentication');
  }

  void _runnerSelected() {
    _showComingNext('Runner authentication');
  }

  void _showComingNext(String destination) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$destination will open here next.'),
        backgroundColor: AppColors.forest,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}