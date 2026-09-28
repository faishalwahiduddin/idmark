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

  @override
  String get selectImageFirst =>
      'Seleccione o tome una foto de su identificación primero.';

  @override
  String checkConfigError(String error) {
    return 'Verifique la configuración: $error';
  }

  @override
  String get watermarkDone => '¡Marca de agua completada!';

  @override
  String get watermarkDoneDesc =>
      'Su documento de identidad ha sido protegido con éxito con una marca de agua de resolución completa y censura permanente 100% en el dispositivo.';

  @override
  String get hashCopied => '¡Hash de integridad copiado al portapapeles!';

  @override
  String get close => 'Cerrar';

  @override
  String get share => 'Compartir';

  @override
  String get resetWatermarkTooltip => 'Restablecer marca de agua';

  @override
  String get configResetKominfo =>
      'Configuración restablecida a los estándares recomendados por Kominfo.';

  @override
  String get bannerUuPdp =>
      'Estándar de la Ley PDP: Agregue una marca de agua con el propósito específico, la fecha y cense los datos confidenciales antes de compartir fotos de su identificación.';

  @override
  String sensorBoxAdded(String label) {
    return 'Se agregó el cuadro de censura \"$label\".';
  }

  @override
  String get processingOnDevice => 'Procesando documento en el dispositivo...';

  @override
  String saveDocument(String format) {
    return 'Guardar documento ($format)';
  }

  @override
  String get shareDirect => 'Compartir directamente';

  @override
  String failedToExport(String error) {
    return 'Error al exportar el documento: $error';
  }

  @override
  String shareSubject(String purpose) {
    return 'Documento de identidad con marca de agua - $purpose';
  }

  @override
  String shareText(String purpose) {
    return 'Documento de identidad seguro con marca de agua vía IDMark ($purpose) • 100% en el dispositivo';
  }

  @override
  String get watermarkConfigTitle => 'Configuración de marca de agua';

  @override
  String get sensorMaskTab => 'Censura / Máscara';

  @override
  String get privacyExifTab => 'Privacidad y EXIF';

  @override
  String get exportFormatTab => 'Formato de exportación';

  @override
  String get watermarkPurposeLabel =>
      'Propósito de la marca de agua (según necesidad)';

  @override
  String get watermarkPurposeHint => 'Ejemplo: VERIFICACIÓN PRÉSTAMO BANCO ABC';

  @override
  String get transactionDate => 'Fecha de transacción';

  @override
  String get includeDateChip => 'Incluir fecha';

  @override
  String get subtextLabel => 'Notas adicionales / Subtexto (opcional)';

  @override
  String get subtextHint => 'Ej.: SOLO PARA FINALIDAD DE EXPEDIENTE INTERNO';

  @override
  String get patternLabel => 'Patrón de sello de marca de agua (7 estilos)';

  @override
  String get colorLabel => 'Color del sello de marca de agua';

  @override
  String get opacityLevel => 'Nivel de opacidad (transparencia)';

  @override
  String get watermarkFontSize => 'Tamaño de fuente de marca de agua';

  @override
  String get rotationAngle => 'Ángulo de rotación';

  @override
  String get redactionIntro =>
      'Cubra datos vitales como firmas o dígitos de identidad no relevantes para minimizar el riesgo de robo de identidad.';

  @override
  String get quickSensorLabel => 'Agregar censura rápida:';

  @override
  String get sensorNik => 'Censurar Nº ID';

  @override
  String get sensorSignature => 'Censurar firma';

  @override
  String get sensorAddress => 'Censurar dirección';

  @override
  String get sensorBirthDate => 'Censurar fecha nac.';

  @override
  String get customArea => 'Área personalizada';

  @override
  String get noRedactionsYet => 'Aún no hay áreas censuradas.';

  @override
  String get deleteSensorTooltip => 'Eliminar censura';

  @override
  String get sensorTypeLabel => 'Tipo de censura:';

  @override
  String positionX(int percent) {
    return 'Posición X ($percent%)';
  }

  @override
  String positionY(int percent) {
    return 'Posición Y ($percent%)';
  }

  @override
  String get privacyComplianceIndex =>
      'Índice de cumplimiento de privacidad documental';

  @override
  String get complianceChecklistTitle =>
      'Lista de verificación de cumplimiento Ley PDP Nº 27/2022:';

  @override
  String get checkPurposeTitle => 'Propósito de uso específico';

  @override
  String get checkPurposeDesc =>
      'Limita el uso de la copia para que no se desvíe a otras transacciones';

  @override
  String get checkDateTitle => 'Fecha de transacción incluida';

  @override
  String get checkDateDesc =>
      'Limita la caducidad del documento para evitar malos usos futuros';

  @override
  String get checkExifTitle => 'Limpiar metadatos EXIF y GPS';

  @override
  String get checkExifDesc =>
      'Elimina las coordenadas geográficas del hogar de los archivos de fotos';

  @override
  String get checkSensorTitle => 'Censurar partes vitales (Nº ID / Firma)';

  @override
  String get checkSensorDesc =>
      'Oculta información no requerida explícitamente por el receptor';

  @override
  String get autoSanitizeExifTitle =>
      'Sanitización automática de metadatos EXIF';

  @override
  String get autoSanitizeExifDesc =>
      'Elimina etiquetas de cámara, modelo de teléfono y coordenadas GPS automáticamente al exportar';

  @override
  String get chooseExportFormat => 'Elija el formato del documento de salida:';

  @override
  String get jpegCompressionQuality => 'Calidad de compresión JPEG';

  @override
  String protectionGrade(String grade, int score) {
    return 'Protección $grade ($score%)';
  }

  @override
  String get viewingOriginal => 'Viendo original';

  @override
  String get holdToCompare => 'Mantener: Comparar';

  @override
  String activeWatermarkWithCount(int count) {
    return 'Marca de agua activa ($count censuras)';
  }

  @override
  String get activeWatermarkPreview => 'Vista previa de marca de agua activa';

  @override
  String get changePhoto => 'Cambiar foto';

  @override
  String get deleteImage => 'Eliminar imagen';

  @override
  String get uploadIdPhoto => 'Subir foto de identificación';

  @override
  String get uploadIdPhotoDesc =>
      'Seleccione una foto de su identificación, licencia o pasaporte para agregar sello de propósito, fecha y censura de datos vitales.';

  @override
  String get onDeviceBadge =>
      '100% en el dispositivo • Las imágenes nunca se envían al servidor';

  @override
  String get openGallery => 'Abrir galería';

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get historyAndAuditLog => 'Historial y registro de auditoría';

  @override
  String get clearAllHistoryTooltip => 'Borrar todo el historial';

  @override
  String get localPrivacyAuditLog =>
      'Registro de auditoría de privacidad local';

  @override
  String localPrivacyAuditLogDesc(int count) {
    return 'Un total de $count documentos se han sellado de forma segura 100% en el dispositivo. Este registro solo se almacena en su dispositivo.';
  }

  @override
  String get searchHistoryHint =>
      'Buscar historial de propósitos de documentos...';

  @override
  String get noWatermarkedDocsYet => 'Aún no hay documentos con marca de agua';

  @override
  String get noWatermarkedDocsDesc =>
      'Los documentos a los que agregue marca de agua y exporte registrarán su auditoría aquí.';

  @override
  String get noHistoryFound =>
      'No se encontró ningún historial que coincida con la búsqueda.';

  @override
  String scoreLabel(int score) {
    return 'Puntuación $score%';
  }

  @override
  String sensitiveSensorsCount(int count) {
    return '$count censuras sensibles';
  }

  @override
  String get exifSanitized => 'EXIF saneado';

  @override
  String get sha256Copied => '¡Hash SHA-256 copiado al portapapeles!';

  @override
  String get clearHistoryConfirmTitle => '¿Borrar todo el historial?';

  @override
  String get clearHistoryConfirmBody =>
      'La lista de auditoría en su dispositivo se eliminará de forma permanente.';

  @override
  String get historyClearedSuccess => 'Historial borrado con éxito.';

  @override
  String get templatePresetHub => 'Centro de plantillas y ajustes';

  @override
  String get createPresetTooltip => 'Crear nuevo ajuste preestablecido';

  @override
  String get officialTemplateCatalog =>
      'Catálogo oficial de plantillas de marcas de agua';

  @override
  String get officialTemplateDesc =>
      'Elija plantillas bancarias, solicitudes de empleo o cree ajustes personalizados guardados en su dispositivo.';

  @override
  String get searchTemplateHint =>
      'Buscar plantillas (banco, préstamos, rrhh, hipoteca, alquiler)...';

  @override
  String showingTemplatesCount(int count) {
    return 'Mostrando $count plantillas';
  }

  @override
  String get createCustom => 'Crear personalizado';

  @override
  String get noTemplatesFound =>
      'No se encontraron plantillas que coincidan con el filtro.';

  @override
  String get customBadge => 'Personalizado';

  @override
  String get deleteCustomPresetTooltip => 'Eliminar ajuste personalizado';

  @override
  String get activeBadge => 'Activo';

  @override
  String patternInfo(String pattern) {
    return 'Patrón: $pattern';
  }

  @override
  String get usePreset => 'Usar ajuste';

  @override
  String presetApplied(String title) {
    return '¡Ajuste \"$title\" aplicado con éxito!';
  }

  @override
  String get createNewCustomPreset => 'Crear nuevo ajuste personalizado';

  @override
  String get presetName => 'Nombre del ajuste';

  @override
  String get presetNameHint => 'Ej.: Verificación de beca';

  @override
  String get category => 'Categoría';

  @override
  String get categoryHint => 'Ej.: Educación / Personalizado';

  @override
  String get purposeTemplateText => 'Texto de plantilla de propósito';

  @override
  String get purposeTemplateHint => 'Ej.: SOLICITUD DE BECA 2026';

  @override
  String get additionalSubtext => 'Subtexto adicional';

  @override
  String get subtextTemplateHint => 'Notas internas';

  @override
  String get stampPattern => 'Patrón de sello';

  @override
  String get savePreset => 'Guardar ajuste';

  @override
  String customPresetSaved(String title) {
    return '¡Ajuste personalizado \"$title\" guardado!';
  }

  @override
  String get deletePresetConfirmTitle => '¿Eliminar ajuste?';

  @override
  String deletePresetConfirmBody(String title) {
    return 'El ajuste \"$title\" se eliminará de su lista local de plantillas.';
  }

  @override
  String get presetDeletedSuccess => 'Ajuste eliminado con éxito.';

  @override
  String get protectDigitalId => 'Proteja su identidad digital';

  @override
  String get protectDigitalIdDesc =>
      'El Ministerio de Comunicación y la Ley PDP exigen precaución al compartir fotos de identificación para evitar préstamos fraudulentos o cuentas ficticias.';

  @override
  String get safeSharingChecklist =>
      'Lista segura antes de enviar su identificación';

  @override
  String checklistDoneCount(int count) {
    return '$count / 5 completado';
  }

  @override
  String get checkItem1 =>
      'Nombre de institución/receptor claramente escrito en la marca de agua';

  @override
  String get checkItem2 => 'Fecha de transacción reciente incluida en el sello';

  @override
  String get checkItem3 =>
      'Marca de agua cruzada sobre el texto para que no pueda recortarse';

  @override
  String get checkItem4 =>
      'Firma censurada si el verificador no solicita espécimen de firma';

  @override
  String get checkItem5 =>
      'Metadatos EXIF y coordenadas GPS eliminados de la imagen';

  @override
  String get zeroServerTitle => 'Privacidad absoluta (sin subida al servidor)';

  @override
  String get zeroServerDesc =>
      'IDMark funciona 100% en su navegador o dispositivo local. Las fotos de identificación nunca se envían, guardan ni procesan en servidores externos.';

  @override
  String get dataSecuritySanitation => 'Saneamiento y seguridad de datos';

  @override
  String get autoExifSubtitle =>
      'Elimina etiquetas de coordenadas GPS y modelo de cámara de las fotos exportadas';

  @override
  String get defaultExportFormat => 'Formato de exportación predeterminado';

  @override
  String get localDeviceStorage => 'Almacenamiento local del dispositivo';

  @override
  String get resetDefaultsDesc =>
      'Restablecer plantillas y ajustes de texto a los valores de fábrica';

  @override
  String get appLabel => 'Aplicación';
}
