import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/core/constants/constants.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';

/// Register Page - Customer Registration Only
/// Only customers can self-register through this page
/// Super Admin, Admin, and Staff accounts are created by administrators
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final isTablet = screenWidth > 600 && screenWidth <= 900;

    authVm.setContext(context);
    authVm.onNavigate = (route) {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(route);
      }
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 40 : (isTablet ? 32 : 24),
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isTablet ? 500 : 450),
                  child: _buildRegisterCard(context, authVm),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterCard(BuildContext context, AuthViewModel authVm) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
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
          // Logo
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary.withOpacity(0.1)),
            ),
            child: const Icon(
              Icons.person_add_outlined,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 24),

          // Title
          const Text(
            'Create Account',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Register as a customer',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textHint,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 32),

          // First Name & Last Name Row
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  value: authVm.registerFirstName,
                  label: 'First Name',
                  hintText: 'John',
                  errorText: authVm.firstNameError,
                  onChanged: authVm.updateRegisterFirstName,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  value: authVm.registerLastName,
                  label: 'Last Name',
                  hintText: 'Doe',
                  errorText: authVm.lastNameError,
                  onChanged: authVm.updateRegisterLastName,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Email Field
          _buildTextField(
            value: authVm.registerEmail,
            label: 'Email',
            hintText: 'john@example.com',
            keyboardType: TextInputType.emailAddress,
            errorText: authVm.registerEmailError,
            onChanged: authVm.updateRegisterEmail,
          ),
          const SizedBox(height: 16),

          // Password Field
          _buildTextField(
            value: authVm.registerPassword,
            label: 'Password',
            hintText: 'Min. 8 characters',
            obscureText: authVm.obscurePassword,
            errorText: authVm.registerPasswordError,
            onChanged: authVm.updateRegisterPassword,
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

          // Confirm Password Field
          _buildTextField(
            value: authVm.confirmPassword,
            label: 'Confirm Password',
            hintText: 'Re-enter password',
            obscureText: authVm.obscurePassword,
            errorText: authVm.confirmPasswordError,
            onChanged: authVm.updateConfirmPassword,
          ),
          const SizedBox(height: 24),

          // Error Message
          if (authVm.error != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.errorLight,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.errorBorder),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.error,
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      authVm.error!,
                      style: const TextStyle(
                        color: AppColors.error,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Register Button - Always registers as CUSTOMER
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: authVm.isLoading
                  ? null
                  : () => authVm.handleRegister(),
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
                      'Create Account',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 24),

          // Info Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.infoLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.info.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.info, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'You will be registered as a customer. Browse businesses and book appointments after registration.',
                    style: TextStyle(fontSize: 12, color: AppColors.info),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Sign In Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String value,
    required String label,
    required String hintText,
    required ValueChanged<String> onChanged,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? errorText,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      initialValue: value,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
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
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        errorText: errorText,
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.error),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
