import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextFieldNotEmpty = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextFieldNotEmpty = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      // Navigate to the ChatScreen, passing the first question
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatScreen(firstMessage: _controller.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tese'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme(!isDarkMode);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text(
              'Hello!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'What can I help you learn today?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.7),
                  ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask about the syllabus...',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send),
                  iconSize: 28,
                  // The button is only enabled if the text field is not empty
                  onPressed: _isTextFieldNotEmpty ? _sendMessage : null,
                  style: IconButton.styleFrom(
                    backgroundColor: _isTextFieldNotEmpty
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Some padding at the bottom
          ],
        ),
      ),
    );
  }
}
