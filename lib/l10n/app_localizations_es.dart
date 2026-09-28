// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'IDMark';

  @override
  String get appDescription => 'Marca de agua segura';

  @override
  String get tabWatermark => 'Marca';

  @override
  String get tabPreset => 'Preajuste';

  @override
  String get tabHistory => 'Historial';

  @override
  String get tabGuide => 'Guía';

  @override
  String get tabSettings => 'Ajustes';

  @override
  String get settings => 'Ajustes';

  @override
  String get appearance => 'Apariencia';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get selectTheme => 'Seleccionar tema';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get localeIndonesian => 'Bahasa Indonesia';

  @override
  String get localeEnglish => 'English';

  @override
  String get localeArabic => 'العربية';

  @override
  String get localeJavanese => 'Basa Jawa';

  @override
  String get localeSundanese => 'Basa Sunda';

  @override
  String get localeChinese => '中文';

  @override
  String get localeJapanese => '日本語';

  @override
  String get localeSpanish => 'Español';

  @override
  String get about => 'Acerca de';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get reset => 'Restablecer';

  @override
  String get kominfoGuide => 'Guía Kominfo';

  @override
  String get history => 'Historial de registros';

  @override
  String get presets => 'Preajustes de usuario';

  @override
  String get resetDefaults => 'Restablecer valores';

  @override
  String get resetWarningTitle => '¿Restablecer preferencias?';

  @override
  String get resetWarningBody =>
      'Su configuración de marca de agua se restaurará a los valores predeterminados.';

  @override
  String get aboutApp => 'Acerca de la aplicación';

  @override
  String get appVersion => 'Versión';

  @override
  String get appDomain => 'Dominio';

  @override
  String get appCompliance => 'Estándar de cumplimiento';

  @override
  String get appProvider => 'Proveedor';

  @override
  String get clearHistory => 'Borrar';

  @override
  String get historyCleared => 'Historial borrado.';

  @override
  String get preferencesReset => 'Preferencias restablecidas.';

  @override
  String get guideRules => '4 Reglas de la marca de agua';

  @override
  String get guideRule1Title => 'Escriba el nombre y el propósito';

  @override
  String get guideRule1Desc =>
      'No escriba solo \"VERIFICACIÓN\". Escriba completamente para evitar el uso indebido.';

  @override
  String get guideRule2Title => 'Incluya la fecha completa';

  @override
  String get guideRule2Desc =>
      'Agregue la fecha para limitar el período de validez del documento.';

  @override
  String get guideRule3Title => 'Posición en diagonal';

  @override
  String get guideRule3Desc =>
      'Coloque la marca de agua en diagonal a través del texto del ID.';

  @override
  String get guideRule4Title => 'Censurar firmas';

  @override
  String get guideRule4Desc =>
      'Cubra su firma para evitar la falsificación de documentos.';

  @override
  String get warningRejectTitle => 'Cuidado con los rechazos';

  @override
  String get warningRejectDesc =>
      'Sospeche de aplicaciones que requieran fotos sin marca de agua.';

  @override
  String get verifiedOfficial => '★ VERIFICADO OFICIALMENTE ★';

  @override
  String get dateLabel => 'FECHA';

  @override
  String get verifyIdentity => 'VERIFICACIÓN DE IDENTIDAD';

  @override
  String get idmarkVerified => 'VERIFICADO POR IDMARK';

  @override
  String get privacySettings => 'Privacidad';

  @override
  String get autoStripExif => 'Eliminar EXIF';

  @override
  String get autoStripExifDesc => 'Eliminar metadatos GPS';

  @override
  String historySubtitle(int count) {
    return '$count registros guardados';
  }

  @override
  String presetsSubtitle(int count) {
    return '$count plantillas guardadas';
  }
}
