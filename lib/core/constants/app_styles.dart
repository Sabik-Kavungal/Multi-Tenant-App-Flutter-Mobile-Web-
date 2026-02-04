import 'package:flutter/material.dart';
import 'package:saasf/core/constants/app_colors.dart';

/// App Styles - Classic & Elegant Design
/// 
/// Typography Scale:
/// - H1: 32px, Light
/// - H2: 24px, Regular  
/// - H3: 20px, Medium
/// - Body: 14px, Regular
/// - Caption: 12px, Regular
/// 
/// Spacing Guidelines:
/// - Small: 8px
/// - Medium: 16px
/// - Large: 24px
/// - Extra Large: 32px
class AppStyles {
  AppStyles._();

  // ============================================
  // SPACING
  // ============================================
  
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 40.0;
  static const double spacingXxxl = 48.0;

  // ============================================
  // BORDER RADIUS
  // ============================================
  
  /// Classic minimal radius
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  
  static BorderRadius borderRadiusSm = BorderRadius.circular(radiusSm);
  static BorderRadius borderRadiusMd = BorderRadius.circular(radiusMd);
  static BorderRadius borderRadiusLg = BorderRadius.circular(radiusLg);

  // ============================================
  // TYPOGRAPHY - HEADINGS (Serif-like, Light)
  // ============================================
  
  /// H1 - 32px, Light weight, letter-spacing
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w300,
    letterSpacing: 1,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  /// H2 - 24px, Regular weight
  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  /// H3 - 20px, Medium weight
  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  /// H4 - 18px, Medium weight
  static const TextStyle h4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // ============================================
  // TYPOGRAPHY - BODY (Sans-serif, Clean)
  // ============================================
  
  /// Body Large - 16px
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  /// Body Medium - 14px (Default)
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  /// Body Small - 13px
  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // ============================================
  // TYPOGRAPHY - CAPTION & LABELS
  // ============================================
  
  /// Caption - 12px
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  /// Label - 14px, Medium weight
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  /// Overline - 11px, Uppercase, Letter-spacing
  static const TextStyle overline = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    color: AppColors.textHint,
    height: 1.4,
  );

  // ============================================
  // TYPOGRAPHY - BUTTON
  // ============================================
  
  /// Button text
  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
    height: 1.2,
  );

  /// Button text small
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // ============================================
  // TYPOGRAPHY - SPECIAL
  // ============================================
  
  /// Welcome title style
  static const TextStyle welcomeTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w300,
    letterSpacing: 3,
    color: AppColors.primary,
  );

  /// Subtitle style
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.secondary,
  );

  /// Italic hint text
  static const TextStyle hint = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: AppColors.textHint,
  );

  /// Link text
  static const TextStyle link = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  // ============================================
  // BOX SHADOWS
  // ============================================
  
  /// Light shadow for cards
  static List<BoxShadow> shadowSm = [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  /// Medium shadow for elevated cards
  static List<BoxShadow> shadowMd = [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  /// Large shadow for modals/dialogs
  static List<BoxShadow> shadowLg = [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 40,
      offset: const Offset(0, 20),
    ),
  ];

  // ============================================
  // INPUT DECORATION
  // ============================================
  
  /// Classic input decoration
  static InputDecoration inputDecoration({
    required String label,
    String? hint,
    Widget? suffixIcon,
    String? errorText,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontSize: 14,
        color: AppColors.secondary,
        fontWeight: FontWeight.w400,
      ),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey[400],
      ),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingMd,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: borderRadiusSm,
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadiusSm,
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadiusSm,
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadiusSm,
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadiusSm,
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      errorText: errorText,
      errorStyle: const TextStyle(
        fontSize: 12,
        color: AppColors.error,
      ),
      filled: true,
      fillColor: AppColors.surface,
    );
  }

  // ============================================
  // BUTTON STYLES
  // ============================================
  
  /// Primary elevated button style
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textOnPrimary,
    elevation: 0,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: spacingLg),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusSm,
    ),
  );

  /// Secondary outlined button style
  static ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: spacingLg),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusSm,
    ),
    side: const BorderSide(color: AppColors.border),
  );

  /// Text button style
  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: AppColors.primary,
    padding: EdgeInsets.zero,
    minimumSize: Size.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  // ============================================
  // CARD DECORATION
  // ============================================
  
  /// Classic card decoration
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: borderRadiusMd,
    boxShadow: shadowMd,
  );

  /// Elevated card decoration
  static BoxDecoration elevatedCardDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: borderRadiusMd,
    boxShadow: shadowLg,
  );

  // ============================================
  // DIVIDER
  // ============================================
  
  /// Horizontal divider
  static Widget divider({double? indent}) {
    return Divider(
      color: AppColors.divider,
      thickness: 1,
      indent: indent,
      endIndent: indent,
    );
  }
}
