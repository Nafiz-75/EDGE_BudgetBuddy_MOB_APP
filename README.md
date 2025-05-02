# EDGE_BudgetBuddy_MOB_APP
BudgetBuddy an expense tracker App which is a Flutter-based app for managing expenses with auth, categories, charts, summaries, and data export. Supports dark mode, Firebase sync, and offline storage. Built with Provider for a seamless experience.

App Name: BudgetBuddy
Purpose:
BudgetBuddy is a personal expense tracking app that allows users to:

Log in or sign up.
Add, view, and search through their expense entries.
See the total amount of money spent.
Maintain a basic user profile.
Switch between light and dark themes.
Use a modern, animated interface with a splash screen and onboarding.

💡 Main Features:
1. Splash Screen:
Displays the app name “💸 BudgetBuddy” briefly on launch.

3. Authentication Screen:
Offers Login and Sign Up options with a swipeable interface.
Transitions to the main app screen after login/signup (no backend used here—just navigation).

4. Main Screen with Tabs:
Home Page:
Displays total expenses.
Shows a list of added expenses with title, amount, and category.
Has a search bar to filter expenses by title.
Allows adding new expenses via a bottom sheet (inputs: title, amount, description, category).

Profile Page:
Displays user's name, email, and phone number.
Shows a profile picture with the initial from their name.

4. Theme Toggle:
Users can toggle between dark and light modes from the login/signup screen or main screen.

🛠️ Technologies Used:
Flutter
Dart
intl package for date formatting
Material Design components

