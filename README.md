# 💰 Nora - Personal Finance Management App

<div align="center">
  <img src="assets/images/app_icon.png" alt="Nora App Icon" width="120" height="120">
  
  <h3>A modern Flutter app for tracking income, expenses, and debt</h3>
  
  [![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
  [![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com/)
  [![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
</div>

## 📱 Features

### 🔐 Authentication
- **Google Sign-In** - Secure authentication with Google
- **Biometric Authentication** - Optional fingerprint/face unlock
- **User Profile Management** - View and manage account details

### 💸 Expense Tracking
- **Three Transaction Types**:
  - 💰 **Income** - Track your earnings
  - 💸 **Expenses** - Monitor spending
  - 📊 **Debt** - Keep track of debts
- **Custom Categories** - Create personalized expense categories
- **Transaction Details** - Title, amount, description, date, and category
- **CRUD Operations** - Full create, read, update, delete functionality

### 📊 Analytics & Insights
- **Financial Dashboard** - Real-time balance calculation
- **Visual Charts** - Interactive circular and bar charts
- **Statistics** - Detailed breakdowns by time periods
- **Transaction History** - Complete timeline of all transactions
- **Top Transactions** - View highest income/expenses/debts

### 🎨 User Experience
- **Modern UI** - Clean, intuitive Material Design interface
- **Dark/Light Theme** - User preference support
- **Responsive Design** - Adapts to different screen sizes
- **Real-time Sync** - Instant updates across devices
- **Offline Support** - Works without internet connection

## 🛠️ Tech Stack

- **Framework**: Flutter 3.2.0+
- **State Management**: Riverpod with Hooks
- **Backend**: Firebase (Firestore, Auth, Analytics, Remote Config)
- **Navigation**: GoRouter
- **Charts**: Syncfusion Flutter Charts
- **Architecture**: Clean Architecture with Domain/Data separation
- **Code Generation**: Freezed, Injectable

## 📦 Dependencies

### Core Dependencies
```yaml
flutter_riverpod: ^2.3.6
hooks_riverpod: latest
firebase_core: latest
firebase_auth: latest
cloud_firestore: latest
go_router: ^10.0.0
```

### UI & Charts
```yaml
syncfusion_flutter_charts: ^22.2.5
responsive_sizer: ^3.2.0
line_icons: ^2.0.3
cached_network_image: ^3.3.1
```

### Utilities
```yaml
freezed_annotation: ^2.1.0
dartz: ^0.10.1
intl: latest
timeago: ^3.5.0
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.2.0 or higher
- Dart SDK 3.0.0 or higher
- Firebase project setup
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/finance_app_repo.git
   cd finance_app_repo
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project
   - Enable Authentication (Google Sign-In)
   - Enable Firestore Database
   - Download and add configuration files:
     - `android/app/google-services.json`
     - `ios/Runner/GoogleService-Info.plist`

4. **Run code generation**
   ```bash
   flutter packages pub run build_runner build
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Screenshots

<div align="center">
  <img src="assets/screenshots/dashboard.png" alt="Dashboard" width="200">
  <img src="assets/screenshots/expense_creation.png" alt="Create Expense" width="200">
  <img src="assets/screenshots/statistics.png" alt="Statistics" width="200">
  <img src="assets/screenshots/profile.png" alt="Profile" width="200">
</div>

## 🏗️ Project Structure

```
lib/
├── domain/                 # Business logic and entities
├── features/              # Feature-based modules
│   ├── auth/             # Authentication screens
│   ├── CreateExpense/    # Expense creation
│   ├── HeaderDashboard/  # Dashboard header
│   ├── homepage/         # Main home screen
│   ├── Profile/          # User profile
│   ├── statistics/       # Analytics and charts
│   └── TransactionList/  # Transaction history
├── model/                # Data models
├── notifer/              # State notifiers
├── provider/             # Riverpod providers
├── state/                # State management classes
├── utils/                # Utility functions and constants
└── main.dart            # App entry point
```

## 🔧 Configuration

### Firebase Configuration
1. Set up Firebase project
2. Enable Google Authentication
3. Configure Firestore security rules
4. Add Remote Config for dynamic settings

### Environment Setup
- Update `lib/firebase_options.dart` with your Firebase configuration
- Configure app icons in `assets/images/app_icon.png`
- Update app name in `lib/utils/string_app.dart`

## 📊 Data Model

```dart
class CreateExpenseModel {
  String name;           // Transaction title
  double amount;         // Transaction amount
  String expenseType;    // Income/Expense/Debt
  String explain;        // Description
  DateTime dateTime;     // Transaction date
  String expenseSubList; // Category/subcategory
}
```

## 🎯 Key Features Explained

### Financial Calculations
- **Total Balance**: Income - (Expenses + Debt)
- **Real-time Updates**: Automatic recalculation on data changes
- **Category Filtering**: Filter transactions by type and category

### State Management
- **Riverpod**: Reactive state management
- **Freezed**: Immutable state classes
- **Real-time Sync**: Firebase listeners for live updates

### Security
- **Firebase Security Rules**: User data isolation
- **Biometric Authentication**: Optional device-level security
- **Data Encryption**: Firebase handles encryption

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Chris Okorie**
- Email: okoriec01@gmail.com
- Portfolio: [chrisdevokorie.unaux.com](http://chrisdevokorie.unaux.com/)
- Support: [Donate](https://justpaga.me/ChrisIuil)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Syncfusion for chart components
- All open-source contributors

## 📞 Support

If you have any questions or need help, feel free to:
- Open an issue on GitHub
- Contact me at okoriec01@gmail.com
- Check out my portfolio for more projects

---

<div align="center">
  Made with ❤️ by Chris Okorie
  
  ⭐ Star this repo if you found it helpful!
</div>