import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:neon_ai_chat_ui_kit_demo/demo_slides.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String gumroadUrl = "https://fixitdev.gumroad.com/l/neon-ai-chat-ui";

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(gumroadUrl))) {
      throw Exception('Could not launch $gumroadUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Neon Title
            const Text(
              "DEMO VERSION",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                shadows: [Shadow(color: Colors.cyan, blurRadius: 20)],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Buy full version for OpenAI + Gemini + bots",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 40),

            // Buy Now Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _launchUrl,
                child: const Text(
                  "BUY NOW - \$39",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // See Demo Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.cyanAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DemoSlides()),
                  );
                },
                child: const Text(
                  "SEE DEMO SLIDES",
                  style: TextStyle(color: Colors.cyanAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
