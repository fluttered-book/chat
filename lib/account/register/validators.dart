String? emailValidator(String? value) =>
    value == null || value.isEmpty ? 'Required' : null;

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Required';
  if (value.length < 8) return '8 characters minimum';
  return null;
}

String? usernameValidator(String? value) {
  if (value == null || value.isEmpty) return 'Required';
  if (!RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(value)) {
    return '3-24 long with alphanumeric or underscore';
  }
  return null;
}
