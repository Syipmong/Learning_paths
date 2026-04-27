import 'package:flutter/material.dart';

class AppColors {
  // Primary Branding (Professional Sage/Forest Green)
  static const Color primaryGreen = Color(0xFF2D6A4F); // Deep, professional green
  static const Color primaryLight = Color(0xFFD8E2DC); // Soft tint for backgrounds
  
  // Secondary / Accent (Deep Navy for contrast)
  static const Color secondaryNavy = Color(0xFF1B4332); 
  static const Color accentTeal = Color(0xFF40916C);

  // Neutrals (Backgrounds & Text)
  static const Color background = Color(0xFFF8F9FA); // Very light grey-white
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1A1C1E); // Almost black
  static const Color textSecondary = Color(0xFF5E6368); // Soft grey for subtitles

  // Semantic Colors (Status)
  static const Color success = Color(0xFF2D6A4F); // Re-use primary or a brighter 2B9348
  static const Color error = Color(0xFFBA1A1A);   // Modern professional red
  static const Color warning = Color(0xFFF9A825); // Muted gold/amber
  static const Color info = Color(0xFF0077B6);    // Calm blue
  
  // To-Do Specific (Priority levels)
  static const Color priorityHigh = Color(0xFFBA1A1A);
  static const Color priorityMedium = Color(0xFFE67E22);
  static const Color priorityLow = Color(0xFF40916C);
}
