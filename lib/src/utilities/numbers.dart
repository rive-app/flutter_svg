/// Parses a `String` to a `double`.
///
/// Passing `null` will return `null`.
///
/// Will strip off a `px` prefix.
/// will convert pt to 1.33px
/// will convert mm to 3.78px
/// will convert % to [parentExtent??100]}px
double? parseDouble(String? maybeDouble,
    {bool tryParse = false, double? fallback, double? parentExtent}) {
  if (maybeDouble == null) {
    return null;
  }
  final String trimmed = maybeDouble.trim();
  if (trimmed.endsWith('pt')) {
    return parseMultiplier(trimmed.replaceFirst('pt', '').trim(),
        tryParse: tryParse, multiplier: 1.33, fallback: fallback);
  } else if (trimmed.endsWith('mm')) {
    return parseMultiplier(trimmed.replaceFirst('mm', '').trim(),
        tryParse: tryParse, multiplier: 3.78, fallback: fallback);
  } else if (trimmed.endsWith('%')) {
    // so we don't really support this. but lets just give it a shot.
    return parseMultiplier(trimmed.replaceFirst('%', '').trim(),
        tryParse: tryParse,
        multiplier: (parentExtent ?? 100) / 100,
        fallback: fallback);
  } else {
    return parseMultiplier(trimmed.replaceFirst('px', '').trim(),
        tryParse: tryParse, fallback: fallback);
  }
}

///
double? parseMultiplier(String maybeDouble,
    {bool tryParse = false, double multiplier = 1, double? fallback}) {
  if (tryParse) {
    final double? result = double.tryParse(maybeDouble);
    if (result == null) {
      if (fallback != null) {
        return fallback * multiplier;
      }
      return null;
    }
    return result * multiplier;
  }
  return double.parse(maybeDouble) * multiplier;
}
