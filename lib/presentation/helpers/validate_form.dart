import 'package:form_field_validator/form_field_validator.dart';

final validatedPhoneForm = MultiValidator([
  RequiredValidator(errorText: 'Celular é necessário'),
  MinLengthValidator(9, errorText: 'Mínimo 9 números')
]);

final validatedEmail = MultiValidator([
  RequiredValidator(errorText: 'Email é necessário'),
  EmailValidator(errorText: 'Digite um email válido')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Senha é necessária'),
  MinLengthValidator(8, errorText: 'Minimo 8 caracteres')
]);
