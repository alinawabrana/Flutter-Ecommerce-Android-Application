import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/utils/formatters/formatter.dart';

class UserModel {
  // Keep those values final which you don't want to update

  final String id;
  String firstName;
  String lastName;
  final String email;
  final String username;
  String phoneNumber;
  String profilePicture;

  /// Constructor for UserModel
  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper function to get th full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(' ');

  /// Static function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = '$firstName$lastName';
    String usernameWithPrefix = 'cwt_$camelCaseUsername';
    return camelCaseUsername;
  }

  /// Static function to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      email: '',
      username: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
      profilePicture: '');

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      // Fetching the inside elements of documentSnapshot
      final data = document.data()!;

      // Creating a new UserModel
      return UserModel(
          id: document.id,
          email: data['Email'] ?? '',
          username: data['Username'] ?? '',
          firstName: data['FirstName'] ?? '',
          lastName: data['LastName'] ?? '',
          phoneNumber: data['PhoneNumber'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '');
    } else {
      return UserModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }
}
