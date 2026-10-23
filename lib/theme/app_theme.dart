import 'package:flutter/material.dart';

/// Taxi dizayn tizimi.
///
/// Barcha ranglar va uslublar shu yerdan boshqariladi.
/// Foydalanish: `context.theme.primary`, `context.text.titleMedium`.
@immutable
class CustomTheme extends ThemeExtension<CustomTheme> {
  const CustomTheme({
    required this.background,
    required this.surface,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.success,
    required this.error,
    required this.warning,
    required this.inputBackground,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.primaryMint,
    required this.brandIndigo,
    required this.backgroundGradient,
    required this.glassFill,
    required this.glassBorder,
    required this.glassShadow,
    required this.glassFillLow,
    required this.glassEdgeShade,
    required this.backdropLight,
    required this.backdropShade,
    required this.orbTopRight,
    required this.orbBottomLeft,
  });

  final Color background;
  final Color primaryMint;
  final Color surface;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color success;
  final Color error;
  final Color warning;
  final Color inputBackground;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color brandIndigo;

  // --- Glassmorphism ---------------------------------------------------------
  final LinearGradient backgroundGradient;
  final Color glassFill;
  final Color glassBorder;
  final Color glassShadow;
  final Color glassFillLow;
  final Color glassEdgeShade;
  final Color backdropLight;
  final Color backdropShade;
  final Color orbTopRight;
  final Color orbBottomLeft;

  @override
  CustomTheme copyWith({
    Color? background,
    Color? surface,
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? success,
    Color? error,
    Color? warning,
    Color? inputBackground,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? primaryMint,
    Color? brandIndigo,
    LinearGradient? backgroundGradient,
    Color? glassFill,
    Color? glassBorder,
    Color? glassShadow,
    Color? glassFillLow,
    Color? glassEdgeShade,
    Color? backdropLight,
    Color? backdropShade,
    Color? orbTopRight,
    Color? orbBottomLeft,
  }) {
    return CustomTheme(
      background: background ?? this.background,
      primaryMint: primaryMint ?? this.primaryMint,
      surface: surface ?? this.surface,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      inputBackground: inputBackground ?? this.inputBackground,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      brandIndigo: brandIndigo ?? this.brandIndigo,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      glassFill: glassFill ?? this.glassFill,
      glassBorder: glassBorder ?? this.glassBorder,
      glassShadow: glassShadow ?? this.glassShadow,
      glassFillLow: glassFillLow ?? this.glassFillLow,
      glassEdgeShade: glassEdgeShade ?? this.glassEdgeShade,
      backdropLight: backdropLight ?? this.backdropLight,
      backdropShade: backdropShade ?? this.backdropShade,
      orbTopRight: orbTopRight ?? this.orbTopRight,
      orbBottomLeft: orbBottomLeft ?? this.orbBottomLeft,
    );
  }

  @override
  CustomTheme lerp(ThemeExtension<CustomTheme>? other, double t) {
    if (other is! CustomTheme) return this;
    return CustomTheme(
      background: Color.lerp(background, other.background, t)!,
      primaryMint: Color.lerp(primaryMint, other.primaryMint, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
      brandIndigo: Color.lerp(brandIndigo, other.brandIndigo, t)!,
      backgroundGradient: LinearGradient.lerp(backgroundGradient, other.backgroundGradient, t)!,
      glassFill: Color.lerp(glassFill, other.glassFill, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      glassShadow: Color.lerp(glassShadow, other.glassShadow, t)!,
      glassFillLow: Color.lerp(glassFillLow, other.glassFillLow, t)!,
      glassEdgeShade: Color.lerp(glassEdgeShade, other.glassEdgeShade, t)!,
      backdropLight: Color.lerp(backdropLight, other.backdropLight, t)!,
      backdropShade: Color.lerp(backdropShade, other.backdropShade, t)!,
      orbTopRight: Color.lerp(orbTopRight, other.orbTopRight, t)!,
      orbBottomLeft: Color.lerp(orbBottomLeft, other.orbBottomLeft, t)!,
    );
  }

  // --- Light Palette ---------------------------------------------------------
  static const CustomTheme light = CustomTheme(
    background: Colors.transparent,
    surface: Color(0xCCFFFFFF),
    primary: Color(0xFFF59E0B), // Taxi Amber / Yellow
    onPrimary: Color(0xFF0F172A),
    secondary: Color(0xFF0284C7),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF64748B),
    border: Color(0xFFE2E8F0),
    primaryMint: Color(0xFF2DD4BF),
    success: Color(0xFF4CE5B1),
    error: Color(0xFFEF4444),
    warning: Color(0xFFF97316),
    inputBackground: Color(0x99F1F5F9),
    shimmerBase: Color(0xFFE2E8F0),
    shimmerHighlight: Color(0xFFF1F5F9),
    brandIndigo: Color(0xFF4F46E5),
    backgroundGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFF4F5F9), Color(0xFFFBFBFD), Color(0xFFEFF1F6)],
    ),
    glassFill: Color(0x66FFFFFF),
    glassBorder: Color(0xFFFFFFFF),
    glassShadow: Color(0x1A1B2140),
    glassFillLow: Color(0x26FFFFFF),
    glassEdgeShade: Color(0x331B2140),
    backdropLight: Color(0xFFFFFFFF),
    backdropShade: Color(0xFFCFF4EE),
    orbTopRight: Color(0x80A7F3D0),
    orbBottomLeft: Color(0x80BAE6FD),
  );

  // --- Dark Palette ----------------------------------------------------------
  static const CustomTheme dark = CustomTheme(
    background: Colors.transparent,
    surface: Color(0xCC1E293B),
    primary: Color(0xFFFBBF24), // Bright Taxi Amber
    onPrimary: Color(0xFF0F172A),
    secondary: Color(0xFF38BDF8),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFF94A3B8),
    border: Color(0xFF334155),
    primaryMint: Color(0xFF2DD4BF),
    success: Color(0xFF4ADE80),
    error: Color(0xFFF87171),
    warning: Color(0xFFFB923C),
    inputBackground: Color(0x33334155),
    shimmerBase: Color(0xFF334155),
    shimmerHighlight: Color(0xFF475569),
    brandIndigo: Color(0xFF6366F1),
    backgroundGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFF16171B), Color(0xFF111215), Color(0xFF181A20)],
    ),
    glassFill: Color(0x29FFFFFF),
    glassBorder: Color(0x66FFFFFF),
    glassShadow: Color(0x66000000),
    glassFillLow: Color(0x0FFFFFFF),
    glassEdgeShade: Color(0x14FFFFFF),
    backdropLight: Color(0xFF2B2E36),
    backdropShade: Color(0xFF07080A),
    orbTopRight: Color(0x405EEAD4),
    orbBottomLeft: Color(0x407DD3FC),
  );
}

/// Burchak radiuslari — loyiha bo'ylab standart o'lchamlar.
abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
}

/// Ilova mavzulari (`MaterialApp` uchun).
abstract final class AppTheme {
  static final ThemeData light = _buildTheme(CustomTheme.light, Brightness.light);
  static final ThemeData dark = _buildTheme(CustomTheme.dark, Brightness.dark);

  static ThemeData _buildTheme(CustomTheme c, Brightness brightness) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: c.primary,
      onPrimary: c.onPrimary,
      secondary: c.secondary,
      onSecondary: c.onPrimary,
      error: c.error,
      onError: Colors.white,
      surface: c.surface,
      onSurface: c.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.transparent,
      fontFamily: 'Roboto',
      extensions: [c],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: c.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(color: c.border, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: c.onPrimary,
          minimumSize: const Size(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: c.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: c.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: c.primary, width: 1.5),
        ),
      ),
    );
  }
}

/// `context.theme` orqali ranglarga tezkor murojaat.
extension CustomThemeX on BuildContext {
  CustomTheme get theme => Theme.of(this).extension<CustomTheme>() ?? CustomTheme.light;
}

/// `context.text` orqali matn uslublariga tezkor murojaat.
extension AppTextX on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
}
