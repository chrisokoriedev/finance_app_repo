# Master Checklist: App Refactoring & AI Integrations

This file tracks the roadmap and tasks for improving the Flutter Finance App (`expense_app`) and the Next.js Portfolio (`webportfolio`). It covers critical bug fixes, UI layouts, state management clean-ups, folder renames, SMS auto-logging, and premium AI features.

---

## 📱 PART 1: Flutter Finance App (`expense_app`)

### 🚀 Phase 1: Critical Bug & Crash Fixes
- [ ] **Uncaught Null Pointer in Item Provider**
  - *File:* [item_provider.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/provider/item_provider.dart#L10-L11)
  - *Fix:* Change `value.currentUser!.uid` to `value.currentUser?.uid` (safe navigator) to prevent crashes when the user is not authenticated.
- [ ] **Text Field Input Validation & Safe Parsing**
  - *File:* [submt_button.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/features/CreateExpense/widget/submt_button.dart#L51-L56)
  - *Fix:* Update validation checks to include `expenseAmountController` is not empty (currently checks `expenseDescripritionController` twice). Use `double.tryParse()` instead of `double.parse()` to prevent format exception crashes.
- [ ] **Safe, Unique Item Deletion**
  - *Files:* [view_expense_timeline.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/features/TransactionList/view_expense_timeline.dart#L138-L142), [cal.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/domain/cal.dart#L122-L127)
  - *Fix:* Modify the expense deletion function to delete by Firestore document ID rather than matching the string name. Ensure `CreateExpenseModel` maps the document ID from Firestore.

### 🎨 Phase 2: Layout & UI Exception Fixes
- [ ] **Safe Overlay for Loading Widget**
  - *File:* [loading.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/utils/loading.dart#L12)
  - *Fix:* Remove the root `Positioned` widget. Replace it with a centered indicator overlay or handle positioning dynamically in a Stack so it doesn't crash outside Stacks.
- [ ] **Standalone Screen Scaffold for Bio Auth**
  - *File:* [bio_auth.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/features/auth/bio_auth.dart#L34)
  - *Fix:* Wrap the root `Padding` inside a `Scaffold` container to render standard app backgrounds and avoid yellow outlines.
- [ ] **ListTile Title & Subtitle RenderFlex Overflows**
  - *File:* [expense_list_builder.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/utils/expense_list_builder.dart#L121-L149)
  - *Fix:* 
    - Remove the `Row` wrapper around title text or use `Expanded`.
    - Wrap the description text inside the subtitle `Row` in `Expanded` to prevent long text from causing right-side overflow crashes.
- [ ] **Profile Page Name/Email Row Overflow**
  - *File:* [profile.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/features/Profile/profile.dart#L63-L78)
  - *Fix:* Convert the side-by-side username/email `Row` to a stacked `Column` to prevent RenderFlex overflow.

### 🧠 Phase 3: Riverpod & State Management Updates
- [ ] **Derived Reactive Totals Provider**
  - *Files:* [cal.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/domain/cal.dart), [header.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/features/HeaderDashboard/header.dart)
  - *Fix:* Deprecate `totalStateProvider` and `TotalNotifier`. Create a derived, reactive `totalsProvider` using `ref.watch(cloudItemsProvider)`. Remove the `ref.read().calculateTotals()` call from `header.dart`'s `build` method.
- [ ] **PageController Memory Leak Fix**
  - *File:* [main_control.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/features/homepage/main_control.dart)
  - *Fix:* Remove the raw `PageController` initialization inside `build`. Change the component to use the `usePageController()` hook since it extends `HookConsumerWidget`.
- [ ] **Synchronous localAuth State Reading**
  - *Files:* [local_auth.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/provider/local_auth.dart), [splashscreen.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/features/auth/splashscreen.dart)
  - *Fix:* Avoid wrapping synchronous shared preferences checks in a `FutureProvider`. Watch `biometricAuthStateProvider` directly to check local auth enablement without visual screen flicker.
- [ ] **Combine Duplicate Biometric Notifiers**
  - *File:* [local_auth.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/notifer/local_auth.dart)
  - *Fix:* Merge `BiometricAuthNotifier` and `BiometricAuthNotifierII` into a single, clean notifier that handles `login`, `create`, and `disable` commands.
- [ ] **Standardize Either Return Contract**
  - *Files:* [cal.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/domain/cal.dart), [categories.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/domain/categories.dart)
  - *Fix:* Align all datasource/service method return values to return `Either<Failure, Success>` where `Left` is consistently failure/error and `Right` is consistently success.
- [ ] **Safe Network Avatar Failback**
  - *File:* [user_avatar.dart](file:///c:/Users/chrisokoriedev/Documents/work/finance_app_repo/lib/utils/user_avatar.dart#L20-L21)
  - *Fix:* Replace the hardcoded Vecteezy vector URL fallback with a local asset image placeholder to ensure offline reliability.

### 🧹 Phase 4: Typo, Style & Dead Code Cleanup
- [ ] **Rename misspelled folder**
  - Move `lib/notifer` to `lib/notifier` and update all imports.
- [ ] **Rename homepage file**
  - Move `lib/features/homepage/hompage.dart` to `lib/features/homepage/homepage.dart` and update all imports.
- [ ] **Fix Global Spelling Typos**
  - Search and replace `TextWigdet` with `TextWidget` across the codebase.
  - Fix `catergory` / `Catergory` to `category` / `Category`.
  - Replace `'Comming soon'` with `'Coming soon'`.
  - Replace `'You vent saved'` with `'You haven't recorded'`.
  - Clean up dead `AppString.hiveDb` configuration and unused `SalesData` class.

### 📲 Phase 5: Auto-Logging Transaction Alerts (SMS & Notifications)
- [ ] **Configure SMS & Notification Reading Permissions**
  - Add `RECEIVE_SMS` and `READ_SMS` permissions to `AndroidManifest.xml` (or set up Android `NotificationListenerService` capability).
- [ ] **Integrate SMS/Notification Listener Service**
  - Install a package like `telephony` or `notification_listener_service` to listen for incoming messages when the app is in the background.
- [ ] **Implement Regex / AI Text Parser**
  - Extract the transaction amount, merchant name, date, and type (Debit -> Expense, Credit -> Income) from standard bank alert formats (e.g. GTB, Zenith, Kuda).
- [ ] **Connect to Expense Database Service**
  - Instantly save the parsed transaction details into Firestore database and trigger Riverpod provider refreshes to update UI balances dynamically.

### 🤖 Phase 6: Advanced AI Features
- [ ] **NLP Auto-Categorization:** Implement dynamic tagging of expense categories using Gemini or Vertex AI based on transaction descriptions.
- [ ] **Receipt Scanner (OCR):** Add a camera utility that extracts merchant, items, date, and amounts from paper receipts.
- [ ] **Voice-to-Expense Logging:** Integrate speech-to-text to let users dictate their expenses.
- [ ] **Interactive Chatbot Advisor:** Integrate Gemini to let users query their budgets and trends via chat.

---

## 💻 PART 2: Next.js Web Portfolio (`webportfolio`)

### 🤖 AI Feature Integrations
- [ ] **Interactive Recruiter Q&A Chatbot:** Integrate Gemini/Vercel AI SDK to let recruiters chat with Christian's resume (`profile.md`).
- [ ] **AI-Driven Project Matcher:** Auto-suggest Christian's past projects (e.g. Blurr, Akojo, FuseLite) based on the user's project requirements in the contact form.

