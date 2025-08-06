
enum MessageSender { user, ai }

class ChatMessage {
  final String text;
  final MessageSender sender;
  final List<String> sourceDocuments; // Add this line

  ChatMessage({
    required this.text,
    required this.sender,
    this.sourceDocuments = const [], // Default to an empty list
  });
}
