extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null ? true : this!.trim().isEmpty;
  bool get isNotNullNorEmpty => !isNullOrEmpty;
}