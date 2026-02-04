# Strict MVVM Architecture - Implementation Guide

## ✅ STRICT MVVM Rules Applied

This Auth module follows **STRICT MVVM** principles with zero exceptions.

## 📋 Architecture Rules

### ✅ Widget Rules (ALL FOLLOWED)
- ✅ **ALL widgets are StatelessWidget** - No StatefulWidget used
- ✅ **UI contains ZERO business logic** - Pure rendering only
- ✅ **UI does NOT handle loading/errors/validation** - All in ViewModel
- ✅ **UI does NOT call services directly** - Only ViewModel methods
- ✅ **ALL button onPressed logic in ViewModel** - `handleLogin()`, `handleLogout()`, etc.
- ✅ **UI only renders state from ViewModel** - Using `context.watch` and `Consumer`
- ✅ **UI does NOT use setState** - Not applicable (all StatelessWidget)
- ✅ **UI does NOT contain if/else business rules** - Only rendering logic

### ✅ ViewModel Responsibilities (ALL IMPLEMENTED)
- ✅ **TextEditingController creation & disposal** - Owned by ViewModel
- ✅ **login() / handleLogin()** - All login logic
- ✅ **logout() / handleLogout()** - All logout logic
- ✅ **restoreSession()** - Session restoration
- ✅ **validate inputs** - `_validateEmail()`, `_validatePassword()`
- ✅ **manage isLoading, errorMessage** - Private state with getters
- ✅ **trigger navigation** - Via `onNavigate` callback

### ✅ UI Responsibilities (ALL FOLLOWED)
- ✅ **Render text fields** - Using ViewModel's controllers
- ✅ **Render buttons** - Pure UI
- ✅ **Bind button presses to ViewModel methods ONLY** - `onPressed: authVm.handleLogin`
- ✅ **Show loading/error based ONLY on ViewModel state** - `authVm.isLoading`, `authVm.error`
- ✅ **No logic, no validation, no API calls** - Pure rendering

## 📁 File Structure

```
lib/features/auth/
├── models/          # Data models (Freezed)
├── services/        # API services
├── viewmodels/
│   └── auth_vm.dart    # ALL business logic here
└── views/
    ├── login_page.dart  # Pure UI - StatelessWidget
    ├── splash_page.dart # Pure UI - StatelessWidget
    └── home_page.dart   # Pure UI - StatelessWidget
```

## 🔍 Code Examples

### LoginPage (StatelessWidget)
```dart
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>(); // Read state
    
    return Scaffold(
      child: Column(
        children: [
          // Uses ViewModel's controller
          TextFormField(
            controller: authVm.emailController,
            errorText: authVm.emailError, // Validation from ViewModel
          ),
          
          // Button calls ViewModel method
          ElevatedButton(
            onPressed: authVm.isLoading ? null : authVm.handleLogin,
            child: authVm.isLoading ? CircularProgressIndicator() : Text('Login'),
          ),
        ],
      ),
    );
  }
}
```

### AuthViewModel (All Logic)
```dart
class AuthViewModel extends ChangeNotifier {
  // ViewModel owns controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // State
  bool _isLoading = false;
  String? _error;
  
  // Getters for UI
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get emailError => _validateEmail();
  
  // Button handler - ALL logic here
  Future<void> handleLogin() async {
    if (!isFormValid) {
      _setError('Please fix form errors');
      return;
    }
    
    _setLoading(true);
    // ... API call, state updates, navigation decision
    onNavigate?.call('/home');
  }
  
  // Validation - ViewModel handles
  String? _validateEmail() {
    return Validators.email(emailController.text.trim());
  }
}
```

## 🎯 Key MVVM Patterns

### 1. State Management
- **ViewModel extends ChangeNotifier**
- **UI uses `context.watch<AuthViewModel>()`** for reactive updates
- **UI uses `context.read<AuthViewModel>()`** for one-time reads

### 2. Navigation
- **ViewModel decides navigation** via `onNavigate` callback
- **UI executes navigation** when callback is triggered
- **No navigation logic in UI**

### 3. Form Handling
- **ViewModel owns TextEditingControllers**
- **ViewModel validates inputs** in real-time
- **UI shows validation errors** from ViewModel state
- **Button disabled based on ViewModel state**

### 4. Loading & Errors
- **ViewModel manages `isLoading` and `error` state**
- **UI renders based on state** - no conditional logic
- **Error display is pure rendering**

## 🚫 What's NOT in UI

❌ No `StatefulWidget`
❌ No `setState()`
❌ No `TextEditingController` creation in UI
❌ No validation logic
❌ No API calls
❌ No navigation decisions
❌ No business rules (if/else for business logic)
❌ No async/await in UI
❌ No error handling logic

## ✅ What IS in UI

✅ Pure widget tree
✅ State reading via `context.watch`
✅ Method calls to ViewModel
✅ Conditional rendering based on ViewModel state
✅ Static UI elements

## 📝 SplashPage Pattern

For StatelessWidget initialization:
```dart
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authVm = context.read<AuthViewModel>();
    
    // Set navigation callback
    authVm.onNavigate = (route) {
      Navigator.of(context).pushReplacementNamed(route);
    };
    
    // Trigger ViewModel method on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authVm.restoreSession(); // ViewModel handles all logic
    });
    
    return Scaffold(/* Pure UI */);
  }
}
```

## 🎓 Interview Talking Points

1. **"All widgets are StatelessWidget"** - Easier to test, no lifecycle management
2. **"ViewModel owns all state"** - Single source of truth
3. **"UI is pure rendering"** - Easy to test, easy to replace
4. **"Navigation via callbacks"** - ViewModel decides, UI executes
5. **"Controllers in ViewModel"** - Proper ownership and disposal
6. **"Real-time validation"** - ViewModel validates, UI displays

## 🔧 Benefits

1. **Testability** - ViewModel can be tested independently
2. **Maintainability** - Clear separation of concerns
3. **Scalability** - Easy to add features following same pattern
4. **Interview Ready** - Demonstrates understanding of MVVM
5. **Production Grade** - Follows industry best practices

---

**This implementation follows STRICT MVVM with zero exceptions.**
