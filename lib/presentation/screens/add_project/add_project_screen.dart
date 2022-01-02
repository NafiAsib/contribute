import 'package:contribute/core/utils/notifier_state.dart';
import 'package:contribute/presentation/screens/add_project/add_project_provider.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final inputController = TextEditingController();
  bool beginner = false;
  bool intermediate = false;
  bool expert = false;
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<AddProjectProvider>(context, listen: false);
    return KeyboardDismisser(
      gestures: const [
        GestureType.onVerticalDragDown,
        GestureType.onTap,
      ],
      child: GestureDetector(
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                Text(
                  'Add your awesome',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Text('open source project')
              ],
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  notifier.repo = inputController.text;
                  notifier.beginner = beginner;
                  notifier.intermediate = intermediate;
                  notifier.expert = expert;
                  notifier.add();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.cloud_upload),
                ),
              ),
            ],
          ),
          body: Consumer<AddProjectProvider>(
            builder: (context, value, child) {
              if (value.notifierState == NotifierState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (value.notifierState == NotifierState.error) {
                return SimpleDialog(
                  title: const Text(
                    'Oh no!! Look\'s like you\'ve made a mistake on repo name! 🤔',
                  ),
                  children: [
                    SimpleDialogOption(
                      onPressed: () {
                        notifier.setInitial();
                      },
                      child: const Center(child: Text('Fill the form again')),
                    ),
                  ],
                );
              } else if (value.notifierState == NotifierState.loaded) {
                return SimpleDialog(
                  title: const Text(
                    'Awesome!! You\'re repository has been added to our database',
                  ),
                  children: [
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/dashboard');
                      },
                      child: const Center(child: Text('Go to dashboard')),
                    ),
                  ],
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'GitHub repository',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: inputController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'ex: facebook/react',
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Tap to choose expected skill level of contributors',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 10,
                            children: [
                              SkillCards(
                                selected: beginner,
                                label: 'Beginner',
                                onTap: () {
                                  beginner = !beginner;
                                  setState(() {});
                                },
                              ),
                              SkillCards(
                                selected: intermediate,
                                label: 'Intermediate',
                                onTap: () {
                                  intermediate = !intermediate;
                                  setState(() {});
                                },
                              ),
                              SkillCards(
                                selected: expert,
                                label: 'Expert',
                                onTap: () {
                                  expert = !expert;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class SkillCards extends StatefulWidget {
  final bool selected;
  final String label;
  final void Function() onTap;
  const SkillCards({
    Key? key,
    required this.selected,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SkillCards> createState() => _SkillCardsState();
}

class _SkillCardsState extends State<SkillCards> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            border: widget.selected
                ? Border.all(color: const Color(0xFF00ADB5))
                : Border.all(color: const Color(0xFFA6E3E9)),
            borderRadius: BorderRadius.circular(13),
            color: const Color(0xFFE3FDFD),
          ),
          child: InkWell(
            onTap: () {
              widget.onTap();
              debugPrint('onTap');
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        widget.selected
            ? Positioned(
                top: -7,
                right: -2,
                child: Container(
                  // color: Colors.white,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFF11999E),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
