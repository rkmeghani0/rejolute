class Font {
  static const Font SfUiBlack = Font("SfUi-Black");
  static const Font SfUiBold = Font("SfUi-Bold");
  static const Font SfUiHeavy = Font("SfUi-Heavy");
  static const Font SfUiLight = Font("SfUi-Light");
  static const Font SfUiMedium = Font("SfUi-Medium");
  static const Font SfUiSemibold = Font("SfUi-Semibold");
  static const Font SfUiThin = Font("SfUi-Thin");
  static const Font SfUiUltralight = Font("SfUi-Ultralight");

  final String _fontName;

  const Font(this._fontName);

  String get value => _fontName;
}
