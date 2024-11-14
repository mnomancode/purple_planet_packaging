import 'package:purple_planet_packaging/app/features/auth/extension/validator_extension.dart';
import 'package:purple_planet_packaging/app/features/auth/schema/login_schema.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../field/field.dart';
import '../model/app_form_state.dart';

part 'login_form_notifier.g.dart';

@riverpod
class LoginFormNotifier extends _$LoginFormNotifier {
  @override
  AppFormState build() {
    return AppFormState(LoginSchema.empty());
  }

  void setEmail(String email) {
    final form = state.form.copyWith(email: Field(value: email));
    late Field<String> emailField;
    final isEmailValid = email.validateEmail();
    if (email.isEmpty) {
      emailField = form.email.copyWith(value: email, errorMessage: null, isValid: false);
    } else if (isEmailValid) {
      emailField = form.email.copyWith(value: email, errorMessage: null, isValid: true);
    } else {
      emailField = form.email.copyWith(
        value: email,
        errorMessage: 'Enter Valid  Email',
        isValid: false,
      );
    }
    state = state.copyWith(form: form.copyWith(email: emailField));
  }

  void setUserNameOrEmail(String email) {
    final form = state.form.copyWith(email: Field(value: email));
    late Field<String> emailField;
    final isEmailValid = email.validateUsernameOrEmail();
    if (email.isEmpty) {
      emailField = form.email.copyWith(value: email, errorMessage: null, isValid: false);
    } else if (isEmailValid) {
      emailField = form.email.copyWith(value: email, errorMessage: null, isValid: true);
    } else {
      emailField = form.email.copyWith(
        value: email,
        errorMessage: 'Enter Valid Username or Email',
        isValid: false,
      );
    }
    state = state.copyWith(form: form.copyWith(email: emailField));
  }

  void setPassword(String password) {
    final form = state.form.copyWith(password: Field(value: password));
    late Field<String> passwordField;
    final isPasswordValid = password.validatePassword();
    if (password.isEmpty) {
      passwordField = form.password.copyWith(value: password, errorMessage: null, isValid: false);
    } else if (isPasswordValid) {
      passwordField = form.password.copyWith(value: password, errorMessage: null, isValid: true);
    } else {
      passwordField = form.password.copyWith(
        value: password,
        errorMessage: 'Enter Valid Password',
        isValid: false,
      );
    }
    state = state.copyWith(form: form.copyWith(password: passwordField));
  }

  void setFirstName(String firstName) {
    final form = state.form.copyWith(firstName: Field(value: firstName));
    late Field<String> firstNameField;
    if (firstName.isEmpty) {
      firstNameField = form.firstName.copyWith(value: firstName, errorMessage: null, isValid: false);
    } else {
      firstNameField = form.firstName.copyWith(value: firstName, errorMessage: null, isValid: true);
    }
    state = state.copyWith(form: form.copyWith(firstName: firstNameField));
  }

  void setLastName(String lastName) {
    final form = state.form.copyWith(lastName: Field(value: lastName));
    late Field<String> lastNameField;
    if (lastName.isEmpty) {
      lastNameField = form.lastName.copyWith(value: lastName, errorMessage: null, isValid: false);
    } else {
      lastNameField = form.lastName.copyWith(value: lastName, errorMessage: null, isValid: true);
    }
    state = state.copyWith(form: form.copyWith(lastName: lastNameField));
  }

  setConfirmPassword(String value, String password) {
    final form = state.form.copyWith(confirmPassword: Field(value: value));
    late Field<String> confirmPasswordField;
    if (value.isEmpty) {
      confirmPasswordField = form.confirmPassword.copyWith(value: value, errorMessage: null, isValid: false);
    } else if (value == password) {
      confirmPasswordField = form.confirmPassword.copyWith(value: value, errorMessage: null, isValid: true);
    } else {
      confirmPasswordField = form.confirmPassword.copyWith(
        value: value,
        errorMessage: 'Password does not match',
        isValid: false,
      );
    }
    state = state.copyWith(form: form.copyWith(confirmPassword: confirmPasswordField));
  }
}
