import 'package:rejolute/util/email_validator.dart';
import 'package:rejolute/util/string_resource.dart';

class Validator {
  static final RegExp _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  static final RegExp _urlRegExp = RegExp(
    r'https?:\/{2}(www.)?[a-z0-9]+\.[a-z]+(\/[a-zA-Z0-9#]+\/?)*',
  );

  static final RegExp _phoneRegFormat = RegExp(r'\(\d{3}\) \d{3}-\d{4}');

  static ValidationState validate(String input, {List<String>? rules}) {
    for (var i = 0; i < rules!.length; i++) {
      String rule = rules[i];
      if (rule == "required") {
        if (input == null || input.trim() == "" || input.isEmpty) {
          return ValidationState(
            status: false,
            error: StringResource.IS_REQUIRED,
          );
        }
      }

      if (rule == "email") {
        if (input == null || input == "") {
          return ValidationState(
            status: false,
            error: StringResource.IS_REQUIRED,
          );
        }
        //print(EmailValidator.validate(input));
        if (!EmailValidator.validate(input)) {
          return ValidationState(
            status: false,
            error: StringResource.FORMAT_IS_INVALID,
          );
        }
      }

      if (rule == "url") {
        if (input == null || input == "") {
          return ValidationState(
              status: false, error: StringResource.IS_REQUIRED);
        }
        if (!_urlRegExp.hasMatch(input)) {
          return ValidationState(
            status: false,
            error: StringResource.FORMAT_IS_INVALID,
          );
        }
      }

      if (rule.startsWith("min:")) {
        try {
          int? letterCount = int.tryParse(rule.replaceAll("min:", ""));
          if (input.length < letterCount!) {
            return ValidationState(
              status: false,
              error: " " +
                  StringResource.SHOULD_BE_MIN +
                  letterCount.toString() +
                  StringResource.CHARACTER_LONG,
            );
          }
        } catch (_) {
          return ValidationState(
            status: false,
            error: " - " + rule + StringResource.IS_INCORRECT,
          );
        }
      }

      if (rule == "us_phone") {
        if (input == null || input == "") {
          return ValidationState(
              status: false, error: StringResource.IS_REQUIRED);
        }

        if (!_phoneRegFormat.hasMatch(input)) {
          return ValidationState(
            status: false,
            error: StringResource.FORMAT_IS_INVALID,
          );
        }
      }

      if (rule == "number_only") {
        RegExp regex = new RegExp(r"(\d+)");
        if (!regex.hasMatch(input))
          return ValidationState(
            status: false,
            error: StringResource.NOT_A_NUMBER,
          );
      }
    }

    return ValidationState(status: true);
  }
}

class ValidationState {
  bool status;
  String? error;

  ValidationState({this.status = false, this.error});
}
