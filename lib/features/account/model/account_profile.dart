class AccountProfile {
  const AccountProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
  });

  factory AccountProfile.mock() {
    return const AccountProfile(
      firstName: 'Adam',
      lastName: 'Khaled',
      email: 'adam.khaled@example.com',
      age: 27,
    );
  }

  final String firstName;
  final String lastName;
  final String email;
  final int age;

  String get fullName => '$firstName $lastName';

  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();
}
