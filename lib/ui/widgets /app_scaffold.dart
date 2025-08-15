import 'package:flutter/material.dart';
import 'package:news/ui/utils%20/app_colors.dart';
import 'package:news/ui/utils%20/extensions/build_context_extensions.dart';

class AppScaffold extends StatefulWidget {
  final String appBarTitle;
  final Widget body;

  const AppScaffold({super.key, required this.body, required this.appBarTitle});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(Icons.menu, color: context.secondaryColor),
            );
          },
        ),
        title: Text(widget.appBarTitle),
        actions: [Icon(Icons.search, color: context.secondaryColor)],
      ),
      drawer: buildDrawer(),
      body: widget.body,
    );
  }

  Widget buildDrawer() => Container(
    color: AppColors.black,
    width: context.width * .7,
    child: Column(
      children: [
        Container(
          height: context.height * .25,
          color: Colors.white,
          child: Center(
            child: Text(
              "News App",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.home_filled, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Go to home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Divider(color: Colors.white),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.brightness_2, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Theme",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              buildThemeDropDown(),
            ],
          ),
        ),
      ],
    ),
  );

  buildThemeDropDown() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<ThemeMode>(
        value: context.themeProvider.themeMode,
        items: [
          DropdownMenuItem(
            value: ThemeMode.light,
            child: Text("Light", style: TextStyle(color: AppColors.white)),
          ),
          DropdownMenuItem(
            value: ThemeMode.dark,
            child: Text("Dark", style: TextStyle(color: AppColors.white)),
          ),
        ],
        dropdownColor: AppColors.black,
        underline: SizedBox(),
        icon: Icon(Icons.arrow_drop_down, color: AppColors.white),
        isExpanded: true,
        onChanged: (newMode) {
          if (newMode == null) return;
          context.themeProvider.changeTheme(newMode);
        },
      ),
    );
  }
}
