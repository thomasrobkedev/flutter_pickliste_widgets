// ignore_for_file: constant_identifier_names

enum Testkey {
  home_page,
  home_menuCounter,

  flushForm,
  flushForm_ok,
  flushForm_cancel,
  flushForm_input,
  flushForm_error,
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

  String append(String suffix) => toString() + suffix;
}
