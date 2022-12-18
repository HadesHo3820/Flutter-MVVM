class SliderObject {
  final String title;
  final String subTitle;
  final String image;
  const SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}

class Customers {
  String id;
  String name;
  int numOfNotifications;
  Customers({
    required this.id,
    required this.name,
    required this.numOfNotifications,
  });
}

class Contacts {
  String email;
  String phone;
  String link;
  Contacts({
    required this.email,
    required this.phone,
    required this.link,
  });
}

class Authentication {
  Customers? customer;
  Contacts? contacts;
  Authentication(this.customer, this.contacts);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo({
    required this.name,
    required this.identifier,
    required this.version,
  });
}
