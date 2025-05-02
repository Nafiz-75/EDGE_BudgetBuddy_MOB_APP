import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(BudgetBuddyApp());
}

class BudgetBuddyApp extends StatefulWidget {
  @override
  State<BudgetBuddyApp> createState() => _BudgetBuddyAppState();
}

class _BudgetBuddyAppState extends State<BudgetBuddyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BudgetBuddy',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey.shade100,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey.shade900,
        cardColor: Colors.grey.shade800,
      ),
      home: SplashScreen(toggleTheme: toggleTheme),
    );
  }
}

// Splash Screen
class SplashScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  SplashScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AuthScreen(toggleTheme: toggleTheme)),
      );
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text(
          '💸 BudgetBuddy',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

// Auth Screen
class AuthScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  AuthScreen({required this.toggleTheme});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _switchPage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                isDark
                    ? [Colors.black87, Colors.black]
                    : [Colors.teal, Colors.teal.shade700],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                _currentIndex == 0 ? "Login" : "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged:
                      (index) => setState(() => _currentIndex = index),
                  children: [
                    AuthCard(isLogin: true, toggleTheme: widget.toggleTheme),
                    AuthCard(isLogin: false, toggleTheme: widget.toggleTheme),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => _switchPage(0),
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () => _switchPage(1),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.brightness_6, color: Colors.white),
                onPressed: widget.toggleTheme,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatelessWidget {
  final bool isLogin;
  final VoidCallback toggleTheme;
  const AuthCard({required this.isLogin, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (!isLogin)
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Full Name"),
                  ),
                SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainScreen(toggleTheme: toggleTheme),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(isLogin ? "Login" : "Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Main App Screen with toggleTheme
class MainScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  MainScreen({required this.toggleTheme});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> _expenses = [];
  final searchController = TextEditingController();

  final nameController = TextEditingController(text: "Nafiz Imtiaz");
  final emailController = TextEditingController(text: "nafiz@example.com");
  final phoneController = TextEditingController(text: "+880123456789");

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();

  List<Map<String, String>> get filteredExpenses {
    return _expenses
        .where(
          (e) => e['title']!.toLowerCase().contains(
            searchController.text.toLowerCase(),
          ),
        )
        .toList();
  }

  void _addExpense() {
    if (titleController.text.isEmpty || amountController.text.isEmpty) return;
    final now = DateTime.now();
    final date = DateFormat("yyyy-MM-dd – kk:mm").format(now);

    setState(() {
      _expenses.add({
        "title": titleController.text,
        "amount": amountController.text,
        "description": descriptionController.text,
        "category": categoryController.text,
        "dateTime": date,
      });
    });

    titleController.clear();
    amountController.clear();
    descriptionController.clear();
    categoryController.clear();
  }

  void _showAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add New Expense",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Title"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(labelText: "Category"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _addExpense();
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Add Expense"),
                ),
              ],
            ),
          ),
    );
  }

  Widget _homePage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: "Search",
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (_) => setState(() {}),
          ),
          SizedBox(height: 16),
          Text(
            "Total: \$${_expenses.fold<double>(0, (sum, item) => sum + double.parse(item['amount']!)).toStringAsFixed(2)}",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: filteredExpenses.length,
              itemBuilder: (ctx, i) {
                var e = filteredExpenses[i];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(e['title']!),
                    subtitle: Text(e['category']!),
                    trailing: Text("\$${e['amount']}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _profilePage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.teal.shade300,
            child: Text(
              nameController.text[0],
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text("Name"),
              subtitle: TextField(controller: nameController),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Icon(Icons.email),
              title: Text("Email"),
              subtitle: TextField(controller: emailController),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Icon(Icons.phone),
              title: Text("Phone"),
              subtitle: TextField(controller: phoneController),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("BudgetBuddy"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: _currentIndex == 0 ? _homePage() : _profilePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      floatingActionButton:
          _currentIndex == 0
              ? FloatingActionButton(
                onPressed: _showAddExpenseSheet,
                backgroundColor: Colors.teal,
                child: Icon(Icons.add),
              )
              : null,
    );
  }
}
