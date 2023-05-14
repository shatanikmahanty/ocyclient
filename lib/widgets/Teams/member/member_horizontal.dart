import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocyclient/models/team/team_model.dart';
import 'package:ocyclient/widgets/Utils/common_widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MemberHorizontal extends StatelessWidget {
  final Member member;

  const MemberHorizontal({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 45.0,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              member.image,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          memberDetails(member),
        ],
      ),
    );
  }

  Widget memberDetails(Member member) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          member.name,
          style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "PublicSans"),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          member.title,
          style: const TextStyle(
              fontSize: 17, color: Colors.white, fontFamily: "PublicSans"),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              if ((member.linkedIn ?? "").isNotEmpty)
                OcyIconButton(
                  title: "",
                  onPressed: () {
                    launchUrlString(member.linkedIn ?? "");
                  },
                  icon: FontAwesomeIcons.linkedinIn,
                  url: member.linkedIn,
                ),
              if ((member.github ?? "").isNotEmpty)
                OcyIconButton(
                  title: "",
                  onPressed: () {
                    launchUrlString(member.github ?? "");
                  },
                  icon: FontAwesomeIcons.github,
                  url: member.github,
                ),
              if ((member.twitter ?? "").isNotEmpty)
                OcyIconButton(
                  title: "",
                  onPressed: () {
                    launchUrlString(member.twitter ?? "");
                  },
                  icon: FontAwesomeIcons.twitter,
                  url: member.twitter,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
