import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'home_screen.dart';

class StudentAuthScreen extends StatefulWidget {
  const StudentAuthScreen({super.key});

  @override
  State<StudentAuthScreen> createState() =>
      _StudentAuthScreenState();
}

class _StudentAuthScreenState extends State<StudentAuthScreen> {
  bool isLogin = true;
  bool obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _departmentController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _departmentController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),

              const SizedBox(height: 28),

              _buildHeading(),

              const SizedBox(height: 26),

              _buildAuthToggle(),

              const SizedBox(height: 28),

              Form(
                key: _formKey,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: isLogin
                      ? _buildLoginForm()
                      : _buildRegistrationForm(),
                ),
              ),

              const SizedBox(height: 25),

              _buildSubmitButton(),

              const SizedBox(height: 20),

              _buildBottomSwitch(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(14),
            child: const SizedBox(
              width: 44,
              height: 44,
              child: Icon(
                Icons.arrow_back_rounded,
                color: AppColors.forest,
                size: 21,
              ),
            ),
          ),
        ),

        const Spacer(),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: AppColors.forest.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.school_rounded,
                size: 14,
                color: AppColors.forest,
              ),
              SizedBox(width: 5),
              Text(
                'STUDENT',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: AppColors.forest,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CAMPUS EATS',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: AppColors.terracotta,
          ),
        ),

        const SizedBox(height: 9),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Text(
            isLogin
                ? 'Welcome\nback.'
                : 'Create your\nstudent account.',
            key: ValueKey(isLogin),
            style: const TextStyle(
              fontSize: 33,
              height: 1.02,
              letterSpacing: -1.1,
              fontWeight: FontWeight.w800,
              color: AppColors.forest,
            ),
          ),
        ),

        const SizedBox(height: 11),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Text(
            isLogin
                ? 'Sign in to continue ordering from campus vendors.'
                : 'Join Campus Eats and get food delivered around campus.',
            key: ValueKey('subtitle_$isLogin'),
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: AppColors.muted,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthToggle() {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton(
              label: 'Login',
              selected: isLogin,
              onTap: () {
                setState(() {
                  isLogin = true;
                });
              },
            ),
          ),
          Expanded(
            child: _buildToggleButton(
              label: 'Register',
              selected: !isLogin,
              onTap: () {
                setState(() {
                  isLogin = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.forest
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: selected
                  ? AppColors.white
                  : AppColors.muted,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      key: const ValueKey('login'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('UNIVERSITY EMAIL / PHONE'),

        const SizedBox(height: 8),

        _buildTextField(
          controller: _emailController,
          hint: 'Enter email or phone number',
          icon: Icons.alternate_email_rounded,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your email or phone number';
            }
            return null;
          },
        ),

        const SizedBox(height: 19),

        _buildFieldLabel('PASSWORD'),

        const SizedBox(height: 8),

        _buildTextField(
          controller: _passwordController,
          hint: 'Enter your password',
          icon: Icons.lock_outline_rounded,
          obscureText: obscurePassword,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 19,
              color: AppColors.muted,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),

        const SizedBox(height: 10),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              _showMessage('Password recovery will be connected later.');
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize:
                  MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Forgot password?',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.terracotta,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return Column(
      key: const ValueKey('register'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('FULL NAME'),

        const SizedBox(height: 8),

        _buildTextField(
          controller: _nameController,
          hint: 'Enter your full name',
          icon: Icons.person_outline_rounded,
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
        ),

        const SizedBox(height: 17),

        _buildFieldLabel('UNIVERSITY EMAIL'),

        const SizedBox(height: 8),

        _buildTextField(
          controller: _emailController,
          hint: 'name@university.edu',
          icon: Icons.alternate_email_rounded,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your university email';
            }

            if (!value.contains('@')) {
              return 'Please enter a valid email';
            }

            return null;
          },
        ),

        const SizedBox(height: 17),

        _buildFieldLabel('PHONE NUMBER'),

        const SizedBox(height: 8),

        _buildTextField(
          controller: _phoneController,
          hint: '03XX XXXXXXX',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),

        const SizedBox(height: 17),

        _buildFieldLabel('PASSWORD'),

        const SizedBox(height: 8),

        _buildTextField(
          controller: _passwordController,
          hint: 'Create a password',
          icon: Icons.lock_outline_rounded,
          obscureText: obscurePassword,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 19,
              color: AppColors.muted,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please create a password';
            }

            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }

            return null;
          },
        ),

        const SizedBox(height: 17),

        _buildFieldLabel('DEPARTMENT'),

        const SizedBox(height: 8),

        _buildTextField(
          controller: _departmentController,
          hint: 'e.g. Computer Science',
          icon: Icons.account_tree_outlined,
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your department';
            }
            return null;
          },
        ),

        const SizedBox(height: 17),

        _buildFieldLabel('HOSTEL / CAMPUS LOCATION'),

        const SizedBox(height: 8),

        _buildTextField(
          controller: _locationController,
          hint: 'e.g. Hostel 4 / Main Campus',
          icon: Icons.location_on_outlined,
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your campus location';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
        color: AppColors.terracotta,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    TextCapitalization textCapitalization =
        TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      validator: validator,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.charcoal,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.muted,
        ),
        prefixIcon: Icon(
          icon,
          size: 19,
          color: AppColors.forest,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.forest,
            width: 1.2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.terracotta,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.terracotta,
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _submit,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forest,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin
                  ? 'Login to Campus Eats'
                  : 'Create Student Account',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 9),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSwitch() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: RichText(
          text: TextSpan(
            text: isLogin
                ? 'New to Campus Eats? '
                : 'Already have an account? ',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.muted,
            ),
            children: [
              TextSpan(
                text: isLogin
                    ? 'Create account'
                    : 'Login',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.terracotta,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (isLogin) {
      _login();
    } else {
      _register();
    }
  }

  void _login() {
    // Temporary frontend behavior.
    // Later this will call Supabase authentication.

    _showMessage('Login successful.');

    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        if (!mounted) return;

        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                const HomeScreen(),
            transitionDuration:
                const Duration(milliseconds: 600),
            transitionsBuilder:
                (_, animation, __, child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
                child: child,
              );
            },
          ),
          (route) => false,
        );
      },
    );
  }

  void _register() {
    // Temporary frontend behavior.
    // Later this will create the student in Supabase.

    _showMessage('Student account created.');

    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        if (!mounted) return;

        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                const HomeScreen(),
            transitionDuration:
                const Duration(milliseconds: 600),
            transitionsBuilder:
                (_, animation, __, child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
                child: child,
              );
            },
          ),
          (route) => false,
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.forest,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}