enum UserType {
  captain(value:  "Driver"),
  owner(value: "Customer");

  const UserType({required this.value});
  final String value;
}
