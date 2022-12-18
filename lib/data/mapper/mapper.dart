// to convert the response into a non nullable object (model)

import 'package:counter/app/extensions.dart';
import 'package:counter/data/responses/responses.dart';
import 'package:counter/domain/model/model.dart';

const empty = "";
const zero = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customers toDomain() {
    return Customers(
        id: this?.id?.orEmpty() ?? empty,
        name: this?.name?.orEmpty() ?? empty,
        numOfNotifications: this?.numOfNotifications?.orZero() ?? zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        email: this?.email?.orEmpty() ?? empty,
        phone: this?.phone?.orEmpty() ?? empty,
        link: this?.link?.orEmpty() ?? empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support.orEmpty() ?? empty;
  }
}
