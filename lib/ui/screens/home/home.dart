import 'package:flutter/material.dart';
import 'package:news/ui/model/category_dm.dart';
import 'package:news/ui/utils%20/app_routes.dart';
import 'package:news/ui/utils%20/extensions/build_context_extensions.dart';
import 'package:news/ui/widgets%20/app_scaffold.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var categories = CategoryDM.getCategories(context.themeProvider.isDarkMode);

    return AppScaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              "Good Morning Here is Some News For You ",
              style: context.textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return buildCategoryWidget(categories, index, context);
              },
            ),
          ),
        ],
      ),
      appBarTitle: "Home",
    );
  }

  Widget buildCategoryWidget(
    List<CategoryDM> categories,
    int index,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(context, AppRoutes.news(categories[index]));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(categories[index].imagePath),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        height: context.height * .25,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: index % 2 == 0
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(categories[index].text, style: context.textTheme.titleLarge),
              Container(
                height: 54,
                width: 157,
                decoration: BoxDecoration(
                  color: context.primaryColor.withAlpha(122),
                  borderRadius: BorderRadius.circular(84),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: index % 2 == 0
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 22),
                    Text("View All", style: context.textTheme.titleLarge),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: context.primaryColor,
                      radius: 24,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: context.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
