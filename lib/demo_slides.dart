import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DemoSlides extends StatefulWidget {
  const DemoSlides({super.key});

  @override
  State<DemoSlides> createState() => _DemoSlidesState();
}

class _DemoSlidesState extends State<DemoSlides> {
  final List<String> slides = [
    'assets/images/main_bot_list_screen.jpeg',
    'assets/images/bot_switch_screen.jpeg',
    'assets/images/bot_management.jpeg',
    'assets/images/bot_creation.jpeg',
    'assets/images/chat_screen_with_ai_response_loading.jpeg',
    'assets/images/chat_screen_with_ai_response.jpeg',
  ];

  int currentIndex = 0;
  final String gumroadUrl = "https://fixitdev.gumroad.com/l/neon-ai-chat-ui";

  void _nextSlide() {
    setState(() {
      if (currentIndex < slides.length - 1) {
        currentIndex++;
      } else {
        _launchUrl();
      }
    });
  }

  void _prevSlide() {
    setState(() {
      if (currentIndex > 0) currentIndex--;
    });
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(gumroadUrl);
    if (!await launchUrl(url)) throw Exception('Could not launch $url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Section: Progress Indicator
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (currentIndex + 1) / slides.length,
                      minHeight: 6,
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.cyanAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Slide ${currentIndex + 1} of ${slides.length}",
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),

            // 2. Middle Section: The Screenshot (Interactive)
            Expanded(
              child: Stack(
                // Stack inside Expanded to keep tap detection over the image
                children: [
                  Center(
                    child: Image.asset(
                      slides[currentIndex],
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Transparent Tap Layers
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: _prevSlide,
                          behavior: HitTestBehavior.translucent,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: _nextSlide,
                          behavior: HitTestBehavior.translucent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 3. Bottom Section: Blurred Navigation Bar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white70),
                          onPressed: () => Navigator.pop(context),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purpleAccent.withValues(
                              alpha: 0.8,
                            ),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _launchUrl,
                          child: const Text("GET FULL ACCESS"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
