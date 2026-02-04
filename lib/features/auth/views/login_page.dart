import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';

/// Login Page - Classic & Elegant Design
/// Minimal, clean, refined spacing
/// Uses AppColors and AppStyles from constants
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 900;
    final isTablet = screenWidth > 600 && screenWidth <= 900;

    // Set context for API calls
    authVm.setContext(context);

    // Always update the navigation callback with fresh context
    authVm.onNavigate = (route) {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(route);
      }
    };

    // Show success message after login
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authVm.showLoginSuccess && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Welcome back, ${authVm.user?.firstName ?? 'User'}!',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.primary,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
        authVm.clearLoginSuccess();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 40 : (isTablet ? 32 : 24),
                vertical: 40,
              ),
              child: isDesktop
                  ? _buildDesktopLayout(context, authVm, screenHeight)
                  : _buildMobileLayout(context, authVm, isTablet),
            ),
          ),
        ),
      ),
    );
  }

  /// Desktop Layout - Two column elegant design
  Widget _buildDesktopLayout(
    BuildContext context,
    AuthViewModel authVm,
    double screenHeight,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left - Branding Panel
              Expanded(flex: 5, child: _buildBrandingPanel()),
              // Right - Login Form
              Expanded(
                flex: 4,
                child: _buildLoginCard(context, authVm, isDesktop: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Mobile Layout - Single card centered
  Widget _buildMobileLayout(
    BuildContext context,
    AuthViewModel authVm,
    bool isTablet,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isTablet ? 450 : 400),
        child: _buildLoginCard(context, authVm, isDesktop: false),
      ),
    );
  }

  /// Branding Panel - Left side on desktop
  Widget _buildBrandingPanel() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 40),

          // Title
          const Text(
            'AI-Powered',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 3,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Appointment',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w300,
              letterSpacing: 1,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const Text(
            'Booking Platform',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w300,
              letterSpacing: 1,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 24),

          // Description
          Text(
            'Smart scheduling with AI wait time predictions\nand intelligent slot recommendations.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.8),
              height: 1.7,
            ),
          ),
          const SizedBox(height: 40),

          // Divider
          Container(width: 40, height: 2, color: AppColors.accent),
          const SizedBox(height: 40),

          // Features
          _buildBrandingFeature(
            Icons.psychology_outlined,
            'AI Predictions',
            'Accurate wait time estimates',
          ),
          const SizedBox(height: 20),
          _buildBrandingFeature(
            Icons.event_available_outlined,
            'Smart Booking',
            'Optimal slot recommendations',
          ),
          const SizedBox(height: 20),
          _buildBrandingFeature(
            Icons.security_outlined,
            'Enterprise Security',
            'JWT & role-based access',
          ),
          const SizedBox(height: 48),

          // Footer
          Text(
            '© 2024 SaaS Platform',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandingFeature(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.7), size: 20),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Login Card - Classic elegant design
  Widget _buildLoginCard(
    BuildContext context,
    AuthViewModel authVm, {
    required bool isDesktop,
  }) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 48 : 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isDesktop
            ? const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              )
            : BorderRadius.circular(8),
        boxShadow: isDesktop
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Mobile Logo
          if (!isDesktop) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary.withOpacity(0.1)),
              ),
              child: const Icon(
                Icons.calendar_today_outlined,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Title
          const Text(
            'Welcome',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w300,
              letterSpacing: 3,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'SaaS Platform',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 16),

          // Subtitle
          const Text(
            'Intelligent appointment booking',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textHint,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 40),

          // Email Field
          _buildClassicTextField(
            value: authVm.loginEmail,
            label: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            errorText: authVm.emailError,
            onChanged: authVm.updateEmail,
          ),
          const SizedBox(height: 16),

          // Password Field
          _buildClassicTextField(
            value: authVm.loginPassword,
            label: 'Password',
            hintText: 'Enter your password',
            obscureText: authVm.obscurePassword,
            errorText: authVm.passwordError,
            onChanged: authVm.updatePassword,
            onSubmitted: (_) => authVm.handleLogin(),
            suffixIcon: IconButton(
              icon: Icon(
                authVm.obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.textHint,
                size: 20,
              ),
              onPressed: authVm.togglePasswordVisibility,
            ),
          ),
          const SizedBox(height: 16),

          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Error Message
          if (authVm.error != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFFFFE0B2)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFE65100),
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      authVm.error!,
                      style: const TextStyle(
                        color: Color(0xFFE65100),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Sign In Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: authVm.isLoading ? null : authVm.handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: authVm.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 24),

          // Divider
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey[300])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'or',
                  style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey[300])),
            ],
          ),
          const SizedBox(height: 24),

          // Social Buttons
          Row(
            children: [
              Expanded(
                child: _buildSocialButton(
                  icon: Icons.g_mobiledata,
                  label: 'Google',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSocialButton(
                  icon: Icons.apple,
                  label: 'Apple',
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Sign Up Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/register'),
                child: const Text(
                  'Create one',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          // Mobile Features
          if (!isDesktop) ...[
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildMobileFeature(
                    Icons.psychology_outlined,
                    'AI-powered wait time predictions',
                  ),
                  const SizedBox(height: 12),
                  _buildMobileFeature(
                    Icons.event_available_outlined,
                    'Smart slot recommendations',
                  ),
                  const SizedBox(height: 12),
                  _buildMobileFeature(
                    Icons.security_outlined,
                    'Enterprise-grade security',
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMobileFeature(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 18),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(fontSize: 13, color: AppColors.secondary),
        ),
      ],
    );
  }

  /// Classic TextField - Minimal elegant design
  /// Uses value + onChanged pattern (via initialValue + key to force rebuild)
  /// This ensures TextField always reflects ViewModel state
  Widget _buildClassicTextField({
    required String value,
    required String label,
    required String hintText,
    required ValueChanged<String> onChanged,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? errorText,
    Widget? suffixIcon,
    ValueChanged<String>? onSubmitted,
  }) {
    return TextFormField(
      initialValue: value,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.secondary,
          fontWeight: FontWeight.w400,
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFE65100)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFE65100), width: 1.5),
        ),
        errorText: errorText,
        errorStyle: const TextStyle(fontSize: 12, color: Color(0xFFE65100)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  /// Social Button - Classic outline style
  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.secondary, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
