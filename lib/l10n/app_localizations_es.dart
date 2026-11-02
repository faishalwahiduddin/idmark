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
  String get localeIndonesian => 'Indonesio';

  @override
  String get localeEnglish => 'Inglés';

  @override
  String get localeArabic => 'Árabe';

  @override
  String get localeJavanese => 'Javanés';

  @override
  String get localeSundanese => 'Sundanés';

  @override
  String get localeChinese => 'Chino';

  @override
  String get localeJapanese => 'Japonés';

  @override
  String get localeSpanish => 'Castellano';

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

  @override
  String get officialKominfoGuide =>
      'Guía oficial de Kominfo y la ley de protección de datos';

  @override
  String get privacyAndSettings => 'Privacidad y ajustes';

  @override
  String get appLanguage => 'Idioma de la aplicación';

  @override
  String get timezone => 'Zona Horaria';

  @override
  String get timezoneAuto => 'Automático (según dispositivo)';

  @override
  String get licenseUsageTitle => 'Licencia de Uso';

  @override
  String get licenseUsageNotice =>
      'Gratis para uso personal y sin fines de lucro.';

  @override
  String get licenseUsageBadgeText => 'Personal y Sin Fines de Lucro';

  @override
  String get validationPurposeRequired =>
      'El propósito de la marca de agua no puede estar vacío';

  @override
  String get validationPurposeMinLength =>
      'El propósito debe tener al menos 3 caracteres';

  @override
  String get validationPurposeMaxLength =>
      'El propósito no puede superar los 60 caracteres';

  @override
  String get validationSubtextMaxLength =>
      'Las notas adicionales no pueden superar los 80 caracteres';

  @override
  String get validationOpacityRange =>
      'La opacidad debe estar entre 10% y 100%';

  @override
  String get validationFontSizeRange =>
      'El tamaño de fuente debe estar entre 10 y 60 pt';

  @override
  String get validationRotationRange =>
      'El ángulo de rotación debe estar entre -90° y +90°';

  @override
  String get validationImageBytesEmpty =>
      'El archivo de imagen está vacío o corrupto';

  @override
  String get validationImageBytesTooLarge =>
      'El tamaño de la imagen supera el límite permitido';

  @override
  String get validationQualityRange =>
      'La calidad de imagen debe estar entre 10% y 100%';

  @override
  String get validationPresetTitleRequired =>
      'El nombre del preset no puede estar vacío';

  @override
  String get validationPresetTitleMinLength =>
      'El nombre del preset debe tener al menos 3 caracteres';

  @override
  String get validationPresetTitleMaxLength =>
      'El nombre del preset no puede superar los 50 caracteres';

  @override
  String get validationPresetCategoryRequired =>
      'La categoría del preset no puede estar vacía';

  @override
  String get validationPresetCategoryMaxLength =>
      'La categoría no puede superar los 30 caracteres';

  @override
  String get privacyGradeDescMax =>
      'Protección máxima • Cumple con los estándares de privacidad de datos';

  @override
  String get privacyGradeDescVeryGood =>
      'Protección muy buena • El documento es seguro para compartir';

  @override
  String get privacyGradeDescFair =>
      'Protección moderada • Se recomienda agregar fecha y censurar la identificación';

  @override
  String get privacyGradeDescWeak =>
      'Protección débil • Agregue propósito específico y fecha';

  @override
  String get appTitle => 'IDMark';

  @override
  String get appTagline =>
      'Estampa una marca de agua de texto en fotos de identidad, licencias y documentos importantes.';

  @override
  String get appSubtitle => 'Protección de identidad y privacidad';

  @override
  String get onbSkip => 'Omitir';

  @override
  String get onbNext => 'Siguiente';

  @override
  String get onbGetStarted => 'Empezar ahora';

  @override
  String get onbPrivacyHeadline => 'Privacidad y modo offline garantizados';

  @override
  String get onbPrivacyDetail =>
      'Todos los datos permanecen seguros en tu dispositivo, sin rastreadores.';

  @override
  String get onbSlide1Title => 'Sello de identidad';

  @override
  String get onbSlide1Sub => 'Propósito y fecha en el documento';

  @override
  String get onbSlide1Badge => '100% offline y privado';

  @override
  String get onbSlide2Title => 'Plantillas';

  @override
  String get onbSlide2Sub => 'Plantillas listas para usar';

  @override
  String get onbSlide2Badge => 'Ligero y ágil';

  @override
  String get onbSlide3Title => 'Historial';

  @override
  String get onbSlide3Sub => 'Resultados guardados';

  @override
  String get onbSlide3Badge => 'Sin anuncios ni cuenta';

  @override
  String get onbSlide4Title => 'En el dispositivo';

  @override
  String get onbSlide4Sub => 'Sin subir a la nube';

  @override
  String get onbSlide4Badge => 'Datos guardados en el dispositivo';

  @override
  String get loadingLabel => 'Cargando…';

  @override
  String get download => 'Descargar';

  @override
  String downloadSuccess(String filename) {
    return '¡Documento con marca de agua descargado ($filename)! 🛡️✨';
  }

  @override
  String get protectionProof => 'Prueba de protección';

  @override
  String get tierExemplary => 'Ejemplar';

  @override
  String get tierDisciplined => 'Constante';

  @override
  String get tierOrderly => 'Ordenado';

  @override
  String get tierStarting => 'Inicio';

  @override
  String disciplineCount(int count, String tier) {
    return '$count archivos con marca • $tier';
  }

  @override
  String get disciplineDesc =>
      'Cada exportación segura refuerza tu disciplina de protección.';

  @override
  String get shareDiscipline => 'Compartir progreso';

  @override
  String disciplineShareText(int count, String tier) {
    return '$count archivos con marca • $tier #IDMark';
  }

  @override
  String get allTemplates => 'Todas';

  @override
  String get myPresets => 'Mis plantillas';

  @override
  String get catBanking => 'Banca';

  @override
  String get catFinance => 'Finanzas y préstamos';

  @override
  String get catCareer => 'Empleo y RR. HH.';

  @override
  String get catRental => 'Alquiler y viajes';

  @override
  String get catTelecom => 'Telecomunicaciones';

  @override
  String get catMultifinance => 'Multifinanciación';

  @override
  String get catInvestment => 'Inversión';

  @override
  String get catPublicService => 'Servicios públicos';

  @override
  String get catInternational => 'Internacional';

  @override
  String get appearanceAndLanguage => 'Apariencia e idioma';

  @override
  String get themeMode => 'Modo de tema';

  @override
  String get identity => 'Identidad';

  @override
  String get patternDiagonalBand => 'Banda diagonal';

  @override
  String get patternDiagonalBandDesc =>
      'Una línea diagonal gruesa sobre el centro del documento (recomendado por Kominfo)';

  @override
  String get patternRepeatedGrid => 'Cuadrícula repetida';

  @override
  String get patternRepeatedGridDesc =>
      'Texto repetido por toda la foto para máxima protección';

  @override
  String get patternBottomBar => 'Barra inferior';

  @override
  String get patternBottomBarDesc =>
      'Una barra de texto sólida en la parte inferior';

  @override
  String get patternCornerStamp => 'Sello en esquina';

  @override
  String get patternCornerStampDesc =>
      'Sello de verificación en la esquina inferior derecha';

  @override
  String get patternSecuritySeal => 'Sello circular';

  @override
  String get patternSecuritySealDesc =>
      'Sello circular doble con borde de verificación';

  @override
  String get patternCrossStamp => 'Cruz doble (X-Band)';

  @override
  String get patternCrossStampDesc =>
      'Dos diagonales cruzadas protegen todo el documento';

  @override
  String get patternQrBadge => 'Insignia QR de verificación';

  @override
  String get patternQrBadgeDesc =>
      'Insignia QR que acredita el propósito y la fecha';

  @override
  String get colorWhite => 'Blanco puro';

  @override
  String get colorDark => 'Negro intenso';

  @override
  String get colorRed => 'Rojo oficial';

  @override
  String get colorBlue => 'Azul verificación';

  @override
  String get colorEmerald => 'Verde seguro';

  @override
  String get colorAmber => 'Amarillo alerta';

  @override
  String get colorPurple => 'Púrpura sello';

  @override
  String get formatPng => 'PNG (resolución completa)';

  @override
  String get formatPngDesc =>
      'Formato sin pérdida que conserva la nitidez original';

  @override
  String get formatJpeg => 'JPEG (tamaño reducido)';

  @override
  String get formatJpegDesc =>
      'Formato comprimido que ahorra datos para subir rápido';

  @override
  String get formatPdf => 'Documento PDF (listo para imprimir)';

  @override
  String get formatPdfDesc => 'Formato oficial usado por oficinas y bancos';

  @override
  String get redactBlackout => 'Censura negra';

  @override
  String get redactBlackoutDesc =>
      'Un recuadro negro permanente sobre los datos';

  @override
  String get redactMosaic => 'Censura con mosaico';

  @override
  String get redactMosaicDesc => 'Pixelado que difumina el texto sensible';

  @override
  String get redactBlur => 'Censura difuminada';

  @override
  String get redactBlurDesc => 'Difuminado que nivela los detalles personales';

  @override
  String get targetNik => 'Número de identidad';

  @override
  String get targetSignature => 'Firma';

  @override
  String get targetAddress => 'Dirección completa';

  @override
  String get targetBirthPlace => 'Lugar y fecha de nacimiento';

  @override
  String get targetPhoto => 'Foto del rostro';

  @override
  String get shareProofTitle => 'Prueba de protección del documento';

  @override
  String get shareProofSubtitle =>
      'Certificado de integridad de marca y censura según Kominfo';

  @override
  String get shareFormatFeed => 'Publicación (4:5)';

  @override
  String get shareFormatStory => 'Historia (9:16)';

  @override
  String get shareCopyText => 'Copiar texto';

  @override
  String get shareProcessing => 'Procesando…';

  @override
  String get shareDownloadProofPng => 'Descargar prueba PNG';

  @override
  String get shareShareProof => 'Compartir prueba';

  @override
  String get shareCardBrand => 'IDMARK • ID SEGURO';

  @override
  String get shareCardOnDevice => '100% EN EL DISPOSITIVO';

  @override
  String get shareCardTitle => 'PRUEBA DE MARCA DE AGUA DEL DOCUMENTO';

  @override
  String get shareCardPurposeLabel => 'PARA EL PROPÓSITO ESPECÍFICO:';

  @override
  String get shareCardPrivacyScore => 'PUNTUACIÓN DE PRIVACIDAD';

  @override
  String get shareCardRedactions => 'CENSURAS';

  @override
  String shareCardAreaCount(int count) {
    return '$count zonas';
  }

  @override
  String get shareCardFormat => 'FORMATO';

  @override
  String shareCardDate(String date) {
    return 'Fecha: $date';
  }

  @override
  String get shareCardFooter =>
      'idmark.faishal.id • Estándar Kominfo para marcas de agua';

  @override
  String get shareCardIntegrityHash => 'HASH DE INTEGRIDAD (SHA-256):';

  @override
  String get shareProofHeading =>
      '🛡️ PRUEBA DE PROTECCIÓN DEL DOCUMENTO — IDMARK';

  @override
  String shareProofPurposeLine(String purpose) {
    return '📌 Propósito específico: \"$purpose\"';
  }

  @override
  String shareProofDateLine(String date) {
    return '📅 Fecha del sello: $date';
  }

  @override
  String shareProofScoreLine(int score) {
    return '🔒 Puntuación de privacidad: $score/100';
  }

  @override
  String shareProofRedactionLine(int count) {
    return '✂️ Censuras permanentes: $count zonas cubiertas';
  }

  @override
  String shareProofHashLine(String hash) {
    return '🔑 Hash SHA-256: $hash';
  }

  @override
  String get shareProofOnDeviceLine =>
      '✅ Procesado 100% en el dispositivo, sin servidor (según Kominfo RI)';

  @override
  String get shareProofCtaLine =>
      'Protege tu identidad con IDMark: https://idmark.faishal.id';

  @override
  String get shareProofDownloaded =>
      '¡Certificado de protección descargado! 🛡️✨';

  @override
  String shareProofFailed(String error) {
    return 'No se pudo compartir la prueba: $error';
  }

  @override
  String get shareProofCopied =>
      '¡Prueba de protección copiada al portapapeles! 📋✨';

  @override
  String get themeCyberShield => 'Escudo ciber';

  @override
  String get themeEmeraldSafe => 'Esmeralda segura';

  @override
  String get themeObsidianVault => 'Bóveda obsidiana';

  @override
  String get themeAmberProof => 'Prueba ámbar';

  @override
  String get quickSensorShort => 'Censura rápida:';

  @override
  String redactedTag(String label) {
    return '[CENSURADO: $label]';
  }

  @override
  String get defaultWatermarkText => 'SOLO PARA VERIFICACIÓN DE IDENTIDAD';

  @override
  String get pdfHeader => 'IDMARK — DOCUMENTO DE IDENTIDAD CON MARCA';

  @override
  String get pdfComplianceNote =>
      'Conforme a los principios de protección de datos (Ley n.º 27/2022)';

  @override
  String get pdfOnDevice => '100% En el dispositivo';

  @override
  String get pdfPurposeLabel => 'Propósito de uso: ';

  @override
  String pdfDateLabel(String date) {
    return 'Fecha de la transacción: $date';
  }

  @override
  String pdfPrintedAt(String date) {
    return 'Impreso el: $date';
  }

  @override
  String get pdfChecksum => 'Suma de verificación SHA-256: ';

  @override
  String get catEcommerce => 'Comercio electrónico';

  @override
  String get presetBank => 'Apertura de cuenta bancaria';

  @override
  String get presetBankUpdate => 'Actualización de datos del cliente';

  @override
  String get presetFintech => 'Fintech / préstamos con licencia OJK';

  @override
  String get presetPaylater => 'Activación de pago aplazado / tarjeta';

  @override
  String get presetJob => 'Solicitud de empleo';

  @override
  String get presetHrOnboarding => 'Incorporación de nuevo empleado';

  @override
  String get presetRental => 'Alquiler de coche o moto';

  @override
  String get presetHotel => 'Registro en hotel, villa o residencia';

  @override
  String get presetTelco => 'Registro de SIM prepago';

  @override
  String get presetSimReplace => 'Reposición de SIM perdida o dañada';

  @override
  String get presetKredit => 'Solicitud de leasing o multifinanciación';

  @override
  String get presetKpr => 'Solicitud de hipoteca o inmueble';

  @override
  String get presetInvestment => 'Cuenta de valores en IDX';

  @override
  String get presetCrypto => 'Verificación de cuenta cripto Bappebti';

  @override
  String get presetEcommerce => 'Verificación de vendedor en marketplace';

  @override
  String get presetBpjs => 'Reclamación de saldo BPJS';

  @override
  String get presetGovKelurahan => 'Registro civil / oficina local';

  @override
  String get presetGlobalKyc => 'Verificación KYC internacional';

  @override
  String get defaultInternalSubtext => 'SOLO PARA DOCUMENTOS INTERNOS';

  @override
  String get pdfLegalNotice =>
      'AVISO LEGAL: Esta copia del documento de identidad solo es válida y está permitida para el propósito indicado arriba. Cualquier otro uso constituye un delito de uso indebido de datos personales.';

  @override
  String get validationRedactionLabelRequired =>
      'La etiqueta de la censura no puede estar vacía';

  @override
  String get validationRedactionXRange =>
      'La posición X de la censura debe estar entre 0.0 y 1.0';

  @override
  String get validationRedactionYRange =>
      'La posición Y de la censura debe estar entre 0.0 y 1.0';

  @override
  String get validationRedactionWidthRange =>
      'El ancho de la censura debe estar entre 0.0 y 1.0';

  @override
  String get validationRedactionHeightRange =>
      'La altura de la censura debe estar entre 0.0 y 1.0';

  @override
  String get validationAuditIdRequired =>
      'El ID del registro de auditoría no puede estar vacío';

  @override
  String get validationAuditPurposeRequired =>
      'El propósito del registro de auditoría no puede estar vacío';

  @override
  String get validationAuditHashRequired =>
      'El hash SHA-256 no puede estar vacío';

  @override
  String get validationAuditScoreRange =>
      'La puntuación de privacidad debe estar entre 0 y 100';
}
