import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Matn uslublari sinfi (`AppTextStyles`) — loyiha bo'ylab yagona shrift va matn shkalasi.
///
/// Foydalanish: `AppTextStyles.headlineLarge(context)`, `AppTextStyles.bodyMedium(context)`.
abstract final class AppTextStyles {
  /// Eng katta sarlavha / displey matni (32 w700)
  static TextStyle displayLarge(BuildContext context) => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.8,
        color: context.theme.textPrimary,
      );

  /// Asosiy ekran sarlavhasi (24 w700)
  static TextStyle headlineLarge(BuildContext context) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
        color: context.theme.textPrimary,
      );

  /// Karta ichidagi katta qiymat yoki bo'lim sarlavhasi (20 w700)
  static TextStyle titleLarge(BuildContext context) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.3,
        color: context.theme.textPrimary,
      );

  /// O'rtacha bo'lim sarlavhasi / AppBar (17 w600)
  static TextStyle titleMedium(BuildContext context) => TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.2,
        color: context.theme.textPrimary,
      );

  /// Ro'yxat qatori sarlavhasi (15 w600)
  static TextStyle titleSmall(BuildContext context) => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: context.theme.textPrimary,
      );

  /// Asosiy qalinroq matn / input matni (16 w500)
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: context.theme.textPrimary,
      );

  /// Oddiy asosiy matn, hint (15 w400)
  static TextStyle bodyMedium(BuildContext context) => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: context.theme.textPrimary,
      );

  /// Ikkinchi darajali xira matn (13 w400)
  static TextStyle bodySmall(BuildContext context) => TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: context.theme.textSecondary,
      );

  /// Tugma yozuvi, asosiy label (15 w600)
  static TextStyle labelLarge(BuildContext context) => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: 0.1,
        color: context.theme.textPrimary,
      );

  /// Chip, input yorlig'i (13 w600)
  static TextStyle labelMedium(BuildContext context) => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: context.theme.textPrimary,
      );

  /// Eng kichik yordamchi matn / badge (12 w500)
  static TextStyle labelSmall(BuildContext context) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: context.theme.textSecondary,
      );
}
