import 'package:flutter/material.dart';
import 'package:voice_assistant/feature_box.dart';
import 'package:voice_assistant/palette.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("Allen"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          //virtual assistant profile section
          Stack(
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
                        image:
                            AssetImage('assets/images/virtualAssistant.png'))),
              )
            ],
          ),
          Container(
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
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Good Morning ..what i can do for you??',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Cera pro',
                    color: Pallete.mainFontColor),
              ),
            ),
          ),
          Container(
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
          //features list
          Column(
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: () {},
        child: const Icon(Icons.mic),
      ),
    );
  }
}
