import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ChatMessage {
  final String text;
  final bool isUser; // true = foydalanuvchi, false = AI
  final File? image;

  ChatMessage({required this.text, required this.isUser, this.image});
}

class MessageAiPage extends StatefulWidget {
  const MessageAiPage({
    super.key,
    required this.salonId,
    required this.salonTitle,
  });

  final String salonId;
  final String salonTitle;

  @override
  State<MessageAiPage> createState() => _MessageAiPageState();
}

class _MessageAiPageState extends State<MessageAiPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _loading = false;

  late final GenerativeModel _model;
  late final ChatSession _chat; // suhbat sessiyasi - tarixni o'zi saqlaydi

  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  bool _isListening = false;
  bool _speechAvailable = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-3.6-flash',
      apiKey: dotenv.env['GEMINI_API_KEY']!,
    );
    _chat = _model.startChat(); // suhbatni boshlaymiz
    _initSpeech();
    _tts.setLanguage('uz-UZ');
  }

  Future<void> _initSpeech() async {
    _speechAvailable = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          setState(() => _isListening = false);
        }
      },
      onError: (error) => setState(() => _isListening = false),
    );
    setState(() {});
  }

  void _toggleListening() async {
    if (!_speechAvailable) return;

    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
    } else {
      setState(() => _isListening = true);
      await _speech.listen(
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
          });
        },
        localeId:
            "uz_UZ", // agar qurilmada o'zbekcha tan olish bo'lmasa "en_US" ishlating
      );
    }
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty && _selectedImage == null) return;
    if (_loading) return;

    final imageToSend = _selectedImage;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text.isEmpty ? '[Rasm]' : text,
          isUser: true,
          image: imageToSend,
        ),
      );
      // AI uchun bo'sh xabar qo'shamiz - uni keyin to'ldirib boramiz
      _messages.add(ChatMessage(text: "", isUser: false));
      _loading = true;
      _selectedImage = null;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      late final Stream<GenerateContentResponse> stream;

      if (imageToSend != null) {
        // Rasm bilan yuborish - Content.multi ishlatiladi
        final imageBytes = await imageToSend.readAsBytes();
        final content = Content.multi([
          TextPart(text.isEmpty ? "Bu rasmda nima bor?" : text),
          DataPart('image/jpeg', imageBytes),
        ]);
        // Eslatma: rasm bilan chat tarixi kontekstiga qo'shish uchun
        // sendMessageStream ishlatamiz, xuddi oldingidek
        stream = _chat.sendMessageStream(content);
      } else {
        stream = _chat.sendMessageStream(Content.text(text));
      }

      await for (final chunk in stream) {
        final chunkText = chunk.text ?? "";
        setState(() {
          final lastIndex = _messages.length - 1;
          _messages[lastIndex] = ChatMessage(
            text: _messages[lastIndex].text + chunkText,
            isUser: false,
          );
        });
        _scrollToBottom();
      }
    } catch (e) {
      setState(() {
        final lastIndex = _messages.length - 1;
        _messages[lastIndex] = ChatMessage(text: "Xatolik: $e", isUser: false);
      });
    } finally {
      setState(() => _loading = false);
      final lastMessage = _messages.last;
      if (!lastMessage.isUser && lastMessage.text.isNotEmpty) {
        _tts.speak(lastMessage.text);
      }
    }
  }

  void _scrollToBottom() {
    // Xabar qo'shilgach avtomatik pastga tushish
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

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 65),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 24.w),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/img_5.png',
                    width: 28.w,
                    height: 28.h,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  widget.salonTitle,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 24.w),
                  child: Image.asset(
                    'assets/images/img_30.png',
                    width: 28.w,
                    height: 28.h,
                  ),
                ),
              ],
            ),
            Expanded(
              child: _messages.isEmpty
                  ? const Center(
                      child: Text(
                        "Suhbatni boshlash uchun xabar yozing 👋",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(12),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return _MessageBubble(message: _messages[index]);
                      },
                    ),
            ),
            if (_loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tanlangan rasm preview'i
            if (_selectedImage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _selectedImage!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () => setState(() => _selectedImage = null),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: _loading ? null : _pickImage,
                ),
                IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: _isListening ? Colors.red : null,
                  ),
                  onPressed: _loading ? null : _toggleListening,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: _isListening ? "Tinglanmoqda..." : "Xabar yozing...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                    textInputAction: TextInputAction.send,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _loading ? null : _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Xabar "bulutchasi" widget
class _MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.image != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(message.image!, height: 150),
                ),
              ),
            Text(
              message.text,
              style: TextStyle(
                color: isUser
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
