import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ocyclient/widgets/Utils/snackbar.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OcyIconButton extends StatelessWidget {
  const OcyIconButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.icon,
    this.url,
  }) : super(key: key);

  final String title;
  final String? url;
  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final button = GestureDetector(
      onTap: onPressed,
      child: OcyIconButtonBody(
        title: title,
        icon: icon,
      ),
    );

    return (kIsWeb && url != null)
        ? _OcyLinkWrapper(
            url: url!,
            child: button,
          )
        : button;
  }
}

class _OcyLinkWrapper extends StatelessWidget {
  const _OcyLinkWrapper({
    Key? key,
    required this.child,
    required this.url,
  }) : super(key: key);

  final Widget child;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: Uri.parse(url),
      builder: (context, _) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: child,
        );
      },
    );
  }
}

class OcyIconButtonBody extends StatelessWidget {
  const OcyIconButtonBody({Key? key, required this.title, required this.icon})
      : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: 30,
            height: 30,
            child: getIconForButton(icon),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        getTextForButton(title)
      ],
    );
  }
}

Widget getTextForButton(String label, {Color? color}) {
  return Text(
    label,
    style: TextStyle(
      color: color ?? Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 19,
      fontFamily: "PublicSans",
    ),
  );
}

Widget getIconForButton(IconData icon) {
  return Icon(
    icon,
    color: const Color(0xff0f254e),
    size: 15,
  );
}

Widget getFooterSocialButton(IconData icon, {String? link}) {
  final button = GestureDetector(
    onTap: () {
      if (link == null) {
        showToast("Coming soon");
      } else {
        launchUrlString(link);
      }
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 30,
        height: 30,
        child: getIconForButton(icon),
      ),
    ),
  );

  return kIsWeb && link != null
      ? _OcyLinkWrapper(
          url: link,
          child: button,
        )
      : button;
}
