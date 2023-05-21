import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistant/feature_box.dart';
import 'package:voice_assistant/openai_service.dart';
import 'package:voice_assistant/palette.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterTts flutterTts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();
  final OpenAIService openAIService = OpenAIService();
  String _lastWords = '';
  String? generatedContent;
  String? generatedImage;
  int start = 200;
  int delay = 200;
  @override
  void initState() {
    super.initState();
    _initSpeech();
    initTexttoSpeech();
  }

  Future<void> initTexttoSpeech() async {
    await flutterTts.setSharedInstance(true);
    await flutterTts.setLanguage("en-US"); // Set the desired language
    await flutterTts.setVoice({"name": "en-us-x-sfg#female_1-local"});
  }

  void _initSpeech() async {
    bool _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  Future<void> speekText(String text) async {
    flutterTts.speak(text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: BounceInDown(child: const Text("Allen")),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          //virtual assistant profile section
          ZoomIn(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                        color: Pallete.assistantCircleColor,
                        shape: BoxShape.circle),
                  ),
                ),
                Container(
                  height: 120,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/virtualAssistant.png'))),
                )
              ],
            ),
          ),
          FadeInRight(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 30).copyWith(top: 30),
              decoration: BoxDecoration(
                  border: Border.all(color: Pallete.borderColor),
                  borderRadius:
                      BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  generatedContent == null
                      ? 'Good Morning ..what i can do for you??'
                      : generatedContent!,
                  style: TextStyle(
                      fontSize: generatedContent == null ? 20 : 17,
                      fontFamily: 'Cera pro',
                      color: Pallete.mainFontColor),
                ),
              ),
            ),
          ),
          if (generatedImage != null) Image.network(generatedImage!),
          Visibility(
            visible: generatedContent == null && generatedImage == null,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10, left: 22),
              child: const Text(
                'Here are a few commands..',
                style: TextStyle(
                    fontFamily: 'Cera pro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          //features list
          Visibility(
            visible: generatedContent == null && generatedImage == null,
            child: Column(
              children: const [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'ChatGBT',
                  description:
                      'a smarter way to stay organized and informed with ChatGBT  ',
                ),
                FeatureBox(
                    color: Pallete.secondSuggestionBoxColor,
                    headerText: 'Dall-E',
                    description:
                        'Get inspired and stay creative with your assistant'),
                FeatureBox(
                    color: Pallete.thirdSuggestionBoxColor,
                    headerText: 'Smart Voice Assistant',
                    description:
                        'Get the best of both of the world wuth the voice assistant')
              ],
            ),
          )
        ],
      ),
      floatingActionButton: ZoomIn(
        child: FloatingActionButton(
          backgroundColor: Pallete.firstSuggestionBoxColor,
          onPressed: () async {
            if (await _speechToText.hasPermission &&
                _speechToText.isNotListening) {
              await _startListening();
            } else if (_speechToText.isListening) {
              await _stopListening();
              print(_lastWords);
              final speech = await openAIService.isArtprompt(_lastWords);
              if (speech.contains('https')) {
                generatedImage = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedContent = speech;
                generatedImage = null;
                await speekText(speech);
                setState(() {});
              }
              print(speech);
            } else {
              _initSpeech();
            }
          },
          child: Icon(_speechToText.isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
