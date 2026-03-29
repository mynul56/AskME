import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ── Colour palette ──────────────────────────────────────────────────────
  static const Color indigoDark  = Color(0xFF1A237E);
  static const Color indigoMed   = Color(0xFF283593);
  static const Color indigoLight = Color(0xFF3949AB);
  static const Color indigoXL    = Color(0xFF5C6BC0);
  static const Color offWhite    = Color(0xFFF5F6FA);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color textDark    = Color(0xFF1A1A2E);
  static const Color textSub     = Color(0xFF64748B);
  static const Color borderLight = Color(0xFFE0E3EF);
  static const Color goldAccent  = Color(0xFFF59E0B);

  // ── Light theme ─────────────────────────────────────────────────────────
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary:    indigoDark,
      secondary:  indigoLight,
      surface:    surfaceWhite,
      onPrimary:  Colors.white,
      onSurface:  textDark,
    ),
    scaffoldBackgroundColor: offWhite,
    textTheme: GoogleFonts.interTextTheme().copyWith(
      headlineLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w900, color: textDark),
      headlineMedium: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: textDark),
      titleLarge:  GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: textDark),
      titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: textDark),
      bodyLarge:   GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400, color: textDark),
      bodyMedium:  GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, color: textSub),
      labelSmall:  GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: textSub, letterSpacing: 1),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: indigoDark,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: const StadiumBorder(),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: indigoDark,
        minimumSize: const Size(double.infinity, 54),
        shape: const StadiumBorder(),
        side: const BorderSide(color: borderLight, width: 1.5),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceWhite,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: borderLight)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: borderLight, width: 1.5)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: indigoDark, width: 2)),
      hintStyle: GoogleFonts.inter(color: textSub, fontSize: 14),
    ),
    cardTheme: CardThemeData(
      color: surfaceWhite,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: offWhite,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: textDark),
      iconTheme: const IconThemeData(color: textDark),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceWhite,
      selectedItemColor: indigoDark,
      unselectedItemColor: textSub,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
  );
}
