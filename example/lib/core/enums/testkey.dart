// ignore_for_file: constant_identifier_names

enum Testkey {
  home_page,
  home_menuPAL,
  home_menuSettings,

  pal_page,
  pal_menuFlushForm,
  pal_menuFormElements,
  pal_menuDiagnostics,

  settings_page,
  settings_menuLanguage,
  settings_menuTheme,

  flushForm_page,

  formElements_page,

  diagnostics_page,

  language_page,
  language_item_,
  language_item_icon_,

  theme_page,
  theme_item_,
  theme_item_icon_,

  flushForm,
  flushForm_ok,
  flushForm_cancel,
  flushForm_input,
  flushForm_error,

  dropdown,
  dropdown_item,
  dropdown_item_icon,
}

extension TestkeyExtension on Testkey {
  String get enabled => toString();
  String get disabled => '${toString()}--disabled';
  String get active => '${toString()}--active';
  String get inactive => '${toString()}--inactive';
  String get selected => '${toString()}--selected';
  String get scrollTo => '${toString()}--scrollTo';
  String get red => '${toString()}--red';

  String isEnabled(bool isEnabled) => isEnabled ? enabled : disabled;
  String isDisabled(bool isDisabled) => isDisabled ? disabled : enabled;
  String isActive(bool isActive) => isActive ? active : inactive;
  String isSelected(bool isSelected) => isSelected ? selected : toString();
  String isScrollTo(bool isScrollTo) => isScrollTo ? scrollTo : toString();
  String isRed(bool isRed) => isRed ? red : toString();

  String append(dynamic suffix) => toString() + suffix.toString();
  String appendWithUnderscore(dynamic suffix) => '${toString()}_$suffix';
  String appendWithModifier(dynamic modifier) => '${toString()}--$modifier';
  String appendWithUnderscoreAndModifier(dynamic suffix, dynamic modifier) => '${toString()}_$suffix--$modifier';
}
