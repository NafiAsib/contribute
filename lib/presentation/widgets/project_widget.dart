import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Project extends StatelessWidget {
  final String maintainer;
  final String name;
  final List<dynamic> topics;
  final int issues;
  final int fork;
  final int stars;
  final String description;
  final bool beginner;
  final bool intermediate;
  final bool expert;
  final String maintainerImage;
  final String url;
  const Project({
    Key? key,
    required this.maintainer,
    required this.name,
    required this.topics,
    required this.issues,
    required this.fork,
    required this.stars,
    required this.description,
    required this.beginner,
    required this.intermediate,
    required this.expert,
    required this.maintainerImage,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFDEFCF9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    if (!await launch(url)) throw 'Could not launch $url';
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.link),
                  ),
                ),
                Center(
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Image.network(
                      maintainerImage,
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      maintainer,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    for (int i = 0; i < topics.length; i++)
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        padding: EdgeInsets.all(6),
                        color: const Color(0xFF61C0BF),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Text(
                              topics[i],
                              style: Theme.of(context).textTheme.headline2,
                            )),
                      ),
                  ],
                ),

                // Text(
                //   'Topics: ${topics.join(', ')}',
                //   style: Theme.of(context).textTheme.headline2,
                // ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoBadge(
                      number: stars,
                      text: 'Stars',
                    ),
                    InfoBadge(
                      number: issues,
                      text: 'Issues',
                    ),
                    InfoBadge(
                      number: fork,
                      text: 'Forks',
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Wrap(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 10,
                  children: [
                    if (beginner) const SkillBadge(skill: 'Beginner'),
                    if (intermediate) const SkillBadge(skill: 'Intermediate'),
                    if (expert) const SkillBadge(skill: 'Expert'),
                    // SizedBox(
                    //   width: 16,
                    // ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoBadge extends StatelessWidget {
  final num number;
  final String text;
  const InfoBadge({
    Key? key,
    required this.number,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFCBF1F5),
        ),
        color: const Color(0xFFE3FDFD),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            number.toString(),
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}

class SkillBadge extends StatelessWidget {
  final String skill;
  const SkillBadge({
    Key? key,
    required this.skill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFCBF1F5),
        ),
        color: const Color(0xFFE3FDFD),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        skill,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
