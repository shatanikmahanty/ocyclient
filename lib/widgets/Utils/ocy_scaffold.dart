import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ocyclient/blocs/auth_bloc.dart';
import 'package:ocyclient/blocs/locale_bloc.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/models/localization/language.dart';
import 'package:provider/provider.dart';

import 'common_widgets.dart';
import 'navigation_drawer.dart';

class OcyScaffold extends StatefulWidget {
  final Widget body;
  final bool enableSelection;

  const OcyScaffold({
    Key? key,
    required this.body,
    this.enableSelection = true,
  }) : super(key: key);

  @override
  State<OcyScaffold> createState() => _OcyScaffoldState();
}

class _OcyScaffoldState extends State<OcyScaffold>
    with TickerProviderStateMixin {
  AnimationController? colorAnimationController;
  Animation? _colorTween;

  @override
  void initState() {
    colorAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    _colorTween = ColorTween(
      begin: Colors.transparent,
      end: Colors.white,
    ).animate(colorAnimationController!);

    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      colorAnimationController?.animateTo(scrollInfo.metrics.pixels / 350);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    NavigationBloc nb = Provider.of<NavigationBloc>(context);
    AuthenticationBloc ab = Provider.of<AuthenticationBloc>(context);
    LocaleBLoc lb = Provider.of<LocaleBLoc>(context);

    return widget.enableSelection
        ? SelectionArea(
            child: getCustomScaffold(size, nb, ab, lb),
          )
        : getCustomScaffold(size, nb, ab, lb);
  }

  Widget getCustomScaffold(
    Size size,
    NavigationBloc nb,
    AuthenticationBloc ab,
    LocaleBLoc lb,
  ) {
    return NotificationListener<ScrollNotification>(
      onNotification: _scrollListener,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: size.width > 900 ? null : const AppDrawer(),
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(size.width, 70),
          child: AnimatedBuilder(
            animation: colorAnimationController!,
            builder: (context, state) {
              return AppBar(
                iconTheme: const IconThemeData(
                  color: Color(0xff152839),
                ),
                backgroundColor: _colorTween == null
                    ? Colors.transparent
                    : _colorTween?.value,
                toolbarHeight: 70,
                elevation: 0,
                titleSpacing: size.width > 900 ? 40 : 0,
                centerTitle: size.width > 900 ? false : true,
                title: size.width > 900
                    ? const SizedBox()
                    : RichText(
                        text: TextSpan(
                          text: "{",
                          style: TextStyle(
                            fontSize:
                                size.width < 1100 && size.width > 900 ? 14 : 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "PublicSans",
                            color: const Color(0xff152839),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: " Open ",
                              style: TextStyle(
                                fontSize: size.width < 1100 && size.width > 900
                                    ? 14
                                    : 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: "Codeyard ",
                              style: TextStyle(
                                fontSize: size.width < 1100 && size.width > 900
                                    ? 14
                                    : 20,
                              ),
                            ),
                            TextSpan(
                              text: "} ;",
                              style: TextStyle(
                                fontSize: size.width < 1100 && size.width > 900
                                    ? 14
                                    : 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                actions: getAppBarActions(nb, size, ab, lb),
              );
            },
          ),
        ),
        body: widget.body,
      ),
    );
  }

  Widget getAppBarButton(String label, NavigationBloc nb, int index) {
    String? name = ModalRoute.of(context)?.settings.name;

    String passedRoute = Config.routeNames.values.toList()[index];
    bool selected = (name != null && name == passedRoute);

    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width < 1100 ? 5 : 10,
          vertical: 4),
      decoration: selected
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 3,
                  color: Color(0xff152839),
                ),
              ),
            )
          : null,
      child: TextButton(
        onPressed: () {
          nb.toRoute(passedRoute);
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width < 1100 ? 12 : 15,
            color: const Color(0xff152839),
            fontFamily: "PublicSans",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  List<Widget> getAppBarActions(
    NavigationBloc nb,
    Size size,
    AuthenticationBloc ab,
    LocaleBLoc lb,
  ) {
    String? name = ModalRoute.of(context)?.settings.name;

    return size.width > 900
        ? [
            const SizedBox(
              width: 60,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "{",
                  style: TextStyle(
                    fontSize: size.width < 1100 && size.width > 900 ? 14 : 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PublicSans",
                    color: const Color(0xff152839),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: " Open ",
                      style: TextStyle(
                        fontSize:
                            size.width < 1100 && size.width > 900 ? 14 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    TextSpan(
                      text: "Codeyard ",
                      style: TextStyle(
                        fontSize:
                            size.width < 1100 && size.width > 900 ? 14 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "} ;",
                      style: TextStyle(
                        fontSize:
                            size.width < 1100 && size.width > 900 ? 14 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ...List.generate(
              Config.routeNames.length,
              (index) {
                return getAppBarButton(
                  Config.routeNames.keys.toList()[index].tr,
                  nb,
                  index,
                );
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 18,
              ),
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Language>(
                    borderRadius: BorderRadius.circular(10),
                    focusColor: Colors.transparent,
                    icon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Icon(
                        FontAwesomeIcons.caretDown,
                        color: Color(0xff152839),
                        size: 16,
                      ),
                    ),
                    dropdownColor: const Color(0xff152839),
                    value: lb.getCurrentSelectedLanguage(),
                    items: Config.languageList.map((Language value) {
                      return DropdownMenuItem<Language>(
                        value: value,
                        child: SizedBox(
                          child: Text(
                            value.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "PublicSans",
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width < 1100
                                  ? 12
                                  : 15,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) {
                      return Config.languageList.map<Widget>((Language value) {
                        return DropdownMenuItem<Language>(
                          value: value,
                          child: Text(
                            value.name.substring(0, 3),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "PublicSans",
                              color: const Color(0xff152839),
                              fontSize: MediaQuery.of(context).size.width < 1100
                                  ? 12
                                  : 15,
                            ),
                          ),
                        );
                      }).toList();
                    },
                    onChanged: (Language? l) {
                      if (l != null) {
                        lb.changeLanguage(l, context);
                      }
                    },
                  ),
                ),
              ),
            ),
            const Spacer(),
            ...[
              ab.isLoggedIn
                  ? GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        _showPopupMenu(details.globalPosition, ab, nb);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: ab.isLoggedIn
                              ? Image.network(
                                  ab.userModel.profilePicUrl,
                                  errorBuilder: (ctx, _, __) {
                                    return const Icon(
                                      FontAwesomeIcons.userSecret,
                                      size: 25,
                                      color: Color(0xff152839),
                                    );
                                  },
                                )
                              : null,
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(4.0),
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width < 1100
                              ? 5
                              : 10),
                      decoration: name != null && name == "/auth"
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          : null,
                      child: TextButton.icon(
                        icon: const Icon(
                          Icons.login,
                          color: Color(0xff152839),
                        ),
                        onPressed: () {
                          nb.toRoute("/auth");
                        },
                        label: const Text(
                          "Log In",
                          style: TextStyle(
                            color: Color(0xff152839),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                width: 15,
              ),
            ]
          ]
        : [];
  }

  void _showPopupMenu(
      Offset offset, AuthenticationBloc ab, NavigationBloc nb) async {
    double left = offset.dx;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left - 50, 65, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: const Color(0xff0f254e),
      items: [
        const PopupMenuItem(
          height: 40,
          value: 1,
          child: SizedBox(
            height: 40,
            width: 120,
            child: OcyIconButtonBody(
              title: "Profile",
              icon: FontAwesomeIcons.user,
            ),
          ),
        ),
        const PopupMenuItem(
          height: 40,
          value: 2,
          child: SizedBox(
            height: 40,
            width: 120,
            child: OcyIconButtonBody(
              title: "Log Out",
              icon: FontAwesomeIcons.rightFromBracket,
            ),
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == 1) {
        nb.toRoute("/profile");
      } else if (value == 2) {
        ab.signOut(context, nb);
      }
    });
  }
}
