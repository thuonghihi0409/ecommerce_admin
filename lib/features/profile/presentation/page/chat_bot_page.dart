//

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';

final supabase = Supabase.instance.client;

class GeminiChatPage extends StatefulWidget {
  const GeminiChatPage({super.key});

  @override
  State<GeminiChatPage> createState() => _GeminiChatPageState();
}

class _GeminiChatPageState extends State<GeminiChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  late final GenerativeModel _model;
  late final ChatSession _chat;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: dotenv.env['GEMINI_API_KEY']!,
    );
    _chat = _model.startChat();
  }

  Future<void> _sendMessage() async {
    final question = _controller.text.trim();
    if (question.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': question});
      _controller.clear();
    });

    scrollToBottom();

    try {
      // 1. Gọi API embedding để tạo embedding cho câu hỏi
      final embeddingModel = GenerativeModel(
        model: 'embedding-001',
        apiKey: dotenv.env['GEMINI_API_KEY']!,
      );

      final result = await embeddingModel.embedContent(
        Content.text(question),
        taskType: TaskType.retrievalQuery,
      );
      final queryEmbedding = result.embedding;

      // 2. Truy vấn Supabase để tìm context liên quan
      final contexts = await _searchKnowledge(queryEmbedding.values);

      final contextText = contexts.map((e) => e['content']).join('\n---\n');

      final fullPrompt = '''
        Dưới đây là các thông tin nội bộ hệ thống:
        $contextText

        Nếu câu hỏi: "$question" có liên quan đến hệ thống hãy dựa vào đó trả lời.
        ''';

      // 3. Gửi đến Gemini cùng context
      final response = await _chat.sendMessage(Content.text(fullPrompt));

      setState(() {
        _messages.add({
          'role': 'bot',
          'text': response.text ?? '❗ Không nhận được phản hồi từ Gemini.'
        });
      });

      scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add({'role': 'bot', 'text': '❗ Đã xảy ra lỗi: $e'});
      });
      log("'role': 'bot', 'text': '❗ Đã xảy ra lỗi: $e'");
      scrollToBottom();
    }
  }

  Future<List<Map<String, dynamic>>> _searchKnowledge(
      List<double> queryEmbedding) async {
    // Chuẩn hóa vector để tránh lỗi truy vấn
    final formattedVector =
        '[${queryEmbedding.map((e) => e.toStringAsFixed(6)).join(', ')}]';

    final response = await supabase.rpc('match_knowledge', params: {
      'query_embedding': formattedVector,
      'match_threshold': 0.75,
      'match_count': 5,
    });

    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    } else {
      return [];
    }
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessage(Map<String, String> message) {
    final isUser = message['role'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
        ),
        child:
            Text(message['text'] ?? '', style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: const CustomAppBar(
        title: "Chatbot",
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Nhập câu hỏi...',
                      filled: true,
                      fillColor: const Color(0xFFF0F0F0),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
