import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/chat_message.dart';
import '../widgets/custom_loader.dart';

class ChatScreen extends StatefulWidget {
  final String firstMessage;
  const ChatScreen({super.key, required this.firstMessage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // Send the initial message from the home screen
    _addMessage(widget.firstMessage, MessageSender.user);
    _fetchApiResponse(widget.firstMessage);
  }

  
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final messageText = _controller.text;
      _addMessage(messageText, MessageSender.user);
      _controller.clear();
      _fetchApiResponse(messageText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversation'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // To show latest messages at the bottom
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          if (_isLoading) const CustomLoader(),
          _buildMessageInput(),
        ],
      ),
    );
  }
Future<void> _fetchApiResponse(String message) async {
  setState(() { _isLoading = true; });

  try {
    // The response is now a Map
    final response = await _apiService.askQuestion(message);
    final String answer = response['answer'] ?? 'No answer found.';
    
    // Extract source documents
    final List<dynamic> sourcesRaw = response['source_documents'] ?? [];
    final List<String> sources = sourcesRaw.map((s) => s['content'] as String).toList();

    _addMessage(answer, MessageSender.ai, sources: sources); // Pass sources here
  } catch (e) {
    _addMessage('Error: ${e.toString()}', MessageSender.ai);
  } finally {
    setState(() { _isLoading = false; });
  }
}

// Update the _addMessage method signature
void _addMessage(String text, MessageSender sender, {List<String> sources = const []}) {
  setState(() {
    _messages.insert(0, ChatMessage(text: text, sender: sender, sourceDocuments: sources));
  });
}

// Update the _buildMessageBubble method to show a source icon
Widget _buildMessageBubble(ChatMessage message) {
  final isUser = message.sender == MessageSender.user;
  final hasSources = message.sourceDocuments.isNotEmpty;

  return Align(
    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isUser
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.text,
            style: TextStyle(
              color: isUser
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onBackground,
            ),
          ),
          // If the message is from the AI and has sources, show a button
          if (!isUser && hasSources)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextButton.icon(
                icon: const Icon(Icons.source, size: 16),
                label: const Text('View Source'),
                onPressed: () => _showSourcesDialog(context, message.sourceDocuments),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

// Add this new method to show a dialog with the sources
void _showSourcesDialog(BuildContext context, List<String> sources) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Source from Syllabus'),
      content: SingleChildScrollView(
        child: Text(sources.join('\n\n---\n\n')),
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Ask a follow-up question...',
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 28,
            onPressed: _sendMessage,
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
          ),
        ],
      ),
    );
  }
}
