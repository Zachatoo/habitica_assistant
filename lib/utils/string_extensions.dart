extension StringExtensions on String? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  bool isNotNullOrEmpty() {
    return this != null && this!.isNotEmpty;
  }
}
