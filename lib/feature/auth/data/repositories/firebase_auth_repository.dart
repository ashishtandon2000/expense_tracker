 /*
🎯 Purpose
    Concrete implementation of AuthRepository. 🔄 Mapping Happens Here

📌 Responsibilities
    Implements AuthRepository
    Uses FirebaseAuthService
    Maps Firebase User → AppUser
    Converts SDK models into domain entity
    Handles transformation logic

This is where:
    Firebase User → AppUser
    conversion must happen.

🚫 Must NOT
    Be used directly by UI
    Expose Firebase types
    Contain UI logic

🧠 Why It Exists
    This is the bridge between:
    Data layer
    Domain layer
    It ensures clean separation and testability.
*/