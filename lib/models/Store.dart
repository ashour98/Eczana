class Store {
  final String name;
  final String phone;

  Store({this.name, this.phone});

  Map<String, dynamic> toJson() => {'name': name, 'phone': phone};
}
