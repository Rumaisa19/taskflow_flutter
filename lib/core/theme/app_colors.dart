import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primaryLight = Color(0xFF7DD3FC); // Soft Cyan
  static const Color primaryDark = Color(0xFF334155); // Cool Slate

  // Background colors
  static const Color backgroundLight = Color(0xFFF8FAFC); // Off-White
  static const Color backgroundDark = Color(
    0xFF1E293B,
  ); // Charcoal / Dark Slate

  // Text colors
  static const Color textPrimaryLight = Color(
    0xFF1E293B,
  ); // Dark text for light mode
  static const Color textPrimaryDark = Color(
    0xFFF8FAFC,
  ); // Light text for dark mode
  static const Color textSecondary = Color(
    0xFF64748B,
  ); // Muted grayish-blue for subtitles

  // Accent colors
  static const Color accent = Color(0xFF22D3EE); // Cyan/Teal highlight
  static const Color success = Color(0xFF4CAF50); // Green for completed tasks
  static const Color warning = Color(0xFFF59E0B); // Amber warning
  static const Color error = Color(0xFFEF4444); // Red for errors

  // Card & UI element colors
  static const Color cardBackgroundLight = Color(0xFFFFFFFF); // Light cards
  static const Color cardBackgroundDark = Color(0xFF334155); // Dark slate cards
  static const Color borderLight = Color(0xFFE2E8F0); // Subtle light border
  static const Color borderDark = Color(0xFF475569); // Subtle dark border
}
