import 'package:flutter/material.dart';

/// App Colors - Classic & Elegant Design
///
/// Color Palette:
/// - Primary: Deep Blue (#1a237e)
/// - Secondary: Warm Gray (#616161)
/// - Accent: Soft Gold (#f9a825)
/// - Background: Off-white (#fafafa)
/// - Text: Charcoal (#212121)
class AppColors {
  AppColors._();

  // ============================================
  // PRIMARY COLORS
  // ============================================

  /// Deep Blue - Primary brand color
  static const Color primary = Color(0xFF1a237e);

  /// Primary with different opacities
  static const Color primaryLight = Color(0xFF534bae);
  static const Color primaryDark = Color(0xFF000051);
  static Color primaryWithOpacity(double opacity) =>
      primary.withOpacity(opacity);

  // ============================================
  // SECONDARY COLORS
  // ============================================

  /// Warm Gray - Secondary color for text and icons
  static const Color secondary = Color(0xFF616161);

  /// Secondary variants
  static const Color secondaryLight = Color(0xFF8e8e8e);
  static const Color secondaryDark = Color(0xFF373737);

  // ============================================
  // ACCENT COLORS
  // ============================================

  /// Soft Gold - Accent color for highlights
  static const Color accent = Color(0xFFf9a825);

  /// Accent variants
  static const Color accentLight = Color(0xFFffd95a);
  static const Color accentDark = Color(0xFFc17900);

  // ============================================
  // BACKGROUND COLORS
  // ============================================

  /// Off-white - Main background
  static const Color background = Color(0xFFFAFAFA);

  /// Pure white - Card backgrounds
  static const Color surface = Color(0xFFFFFFFF);

  /// Light gray background
  static const Color backgroundLight = Color(0xFFF5F5F5);

  // ============================================
  // TEXT COLORS
  // ============================================

  /// Charcoal - Primary text
  static const Color textPrimary = Color(0xFF212121);

  /// Secondary text
  static const Color textSecondary = Color(0xFF616161);

  /// Light text / Hints
  static const Color textHint = Color(0xFF9e9e9e);

  /// Disabled text
  static const Color textDisabled = Color(0xFFBDBDBD);

  /// White text (for dark backgrounds)
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ============================================
  // BORDER COLORS
  // ============================================

  /// Light border
  static const Color border = Color(0xFFE0E0E0);

  /// Divider color
  static const Color divider = Color(0xFFEEEEEE);

  // ============================================
  // STATUS COLORS
  // ============================================

  /// Success - Green
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFE8F5E9);

  /// Error - Orange/Amber (classic style)
  static const Color error = Color(0xFFE65100);
  static const Color errorLight = Color(0xFFFFF3E0);
  static const Color errorBorder = Color(0xFFFFE0B2);

  /// Warning - Amber
  static const Color warning = Color(0xFFFFA000);
  static const Color warningLight = Color(0xFFFFF8E1);

  /// Info - Blue
  static const Color info = Color(0xFF1976D2);
  static const Color infoLight = Color(0xFFE3F2FD);

  // ============================================
  // SHADOW COLORS
  // ============================================

  /// Light shadow
  static Color shadowLight = Colors.black.withOpacity(0.08);

  /// Medium shadow
  static Color shadowMedium = Colors.black.withOpacity(0.12);

  /// Dark shadow
  static Color shadowDark = Colors.black.withOpacity(0.16);

  // ============================================
  // GRADIENT DEFINITIONS
  // ============================================

  /// Primary gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  // ============================================
  // HELPER METHODS
  // ============================================

  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
