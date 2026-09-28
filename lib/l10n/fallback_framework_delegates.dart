import 'package:flutter/cupertino.dart' show CupertinoLocalizations;
import 'package:flutter/material.dart' show MaterialLocalizations;
import 'package:flutter/widgets.dart'
    show WidgetsLocalizations, Locale, LocalizationsDelegate;
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;

/// flutter_localizations ships full Widgets/Material/Cupertino
/// framework-chrome translations for ~78 languages -- Javanese (`jv`) and
/// Sundanese (`su`) are not among them. Without these wrappers, selecting jv
/// or su crashes any Cupertino/Material widget that requires framework
/// localizations (e.g. `CupertinoTabBar` throws "No CupertinoLocalizations
/// found"), because `Localizations` silently omits the delegate's output
/// from the widget tree for locales it doesn't claim to support.
///
/// Each wrapper claims support for every locale and substitutes a supported
/// fallback locale before delegating to the real `Global*Localizations`
/// delegate. This only affects framework chrome strings (e.g. the default
/// "Cut"/"Copy"/"Paste" edit menu) for jv/su -- this app's own content
/// (`AppLocalizations`) is unaffected, since it has full jv/su translations.
const _fallbackForUnsupportedFrameworkLocale = Locale('en');

class FallbackWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const FallbackWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    final delegate = GlobalWidgetsLocalizations.delegate;
    final resolved = delegate.isSupported(locale)
        ? locale
        : _fallbackForUnsupportedFrameworkLocale;
    return delegate.load(resolved);
  }

  @override
  bool shouldReload(FallbackWidgetsLocalizationsDelegate old) => false;
}

class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    final delegate = GlobalMaterialLocalizations.delegate;
    final resolved = delegate.isSupported(locale)
        ? locale
        : _fallbackForUnsupportedFrameworkLocale;
    return delegate.load(resolved);
  }

  @override
  bool shouldReload(FallbackMaterialLocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    final delegate = GlobalCupertinoLocalizations.delegate;
    final resolved = delegate.isSupported(locale)
        ? locale
        : _fallbackForUnsupportedFrameworkLocale;
    return delegate.load(resolved);
  }

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}
