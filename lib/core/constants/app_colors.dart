import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const primary = Color(0xFF2E7D32); // Deep Green
  static const secondary = Color(0xFF4CAF50); // Green
  
  // Accent Colors
  static const accent = Color(0xFFA5D6A7); // Soft Green highlight
  static const secondaryLight = Color(0xFF81C784);
  
  // Background Colors
  static const background = Color(0xFFF9FBE7);
  static const cardBackground = Color(0xFFFFFFFF);
  static const backgroundWhite = Color(0xFFFFFFFF); // Deprecated: use cardBackground
  
  // Text Colors
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const text = Color(0xFF212121); // Deprecated: use textPrimary
  static const textGrey = Color(0xFF757575); // Deprecated: use textSecondary
  
  // Earth Accent
  static const earthAccent = Color(0xFF8D6E63);
  static const earthTone = Color(0xFF8D6E63); // Deprecated: use earthAccent
  
  // Gradient (for Card / Header)
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Shadow
  static const softShadow = BoxShadow(
    color: Color(0x14000000), // rgba(0,0,0,0.08)
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  );
}

// Spacing System (4px grid)
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  
  // Card specific
  static const double cardPadding = 16.0;
  static const double cardRadius = 16.0;
}
