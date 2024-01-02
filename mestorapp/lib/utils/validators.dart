String? nonEmptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field can not be empty';
  }
  return null;
}
