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
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 10),
          Text(
            'Maintained by: $maintainer',
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 6),
          Text(
            'Topics: ${topics.join(', ')}',
            style: Theme.of(context).textTheme.headline2,
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
