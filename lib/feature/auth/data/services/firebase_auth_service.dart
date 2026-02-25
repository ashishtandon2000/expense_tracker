/*
🎯 Purpose
    Low-level wrapper around FirebaseAuth SDK.

📌 Responsibilities
    Talk directly to Firebase SDK
    Perform Google OAuth credential handling
    Call FirebaseAuth.instance
    Return Firebase User?
    Expose raw authStateChanges() stream

🚫 Must NOT
    Return AppUser
    Know about repository
    Know about ViewModel
    Contain business mapping logic

🧠 Why It Exists
    Separates raw SDK interaction from repository logic.
*/