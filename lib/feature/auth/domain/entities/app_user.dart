/*
🎯 Purpose
    Represents the authenticated user inside your app.

📌 Responsibilities
    Pure business entity
    No Firebase imports
    No JSON logic
    No mapping logic
    No Flutter dependency

🚫 Must NOT
    Import firebase_auth
    Contain fromJson / toJson
    Know about services
    Contain business logic

🧠 Why It Exists
    To prevent Firebase types leaking into ViewModel or UI.
*/

class AppUser {
  final String id;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  const AppUser({required this.id, this.email, this.displayName, this.photoUrl});

  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl)';
  }
}
