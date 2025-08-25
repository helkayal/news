import 'package:news/ui/utils%20/app_assets.dart';

class CategoryDM {
  String id;
  String text;
  String imagePath;

  CategoryDM(this.id, this.text, this.imagePath);

  static List<CategoryDM> getCategories(bool isDarkMode) {
    return [
      CategoryDM(
        "general",
        "general",
        !isDarkMode ? AppAssets.generalDark : AppAssets.generalLight,
      ),

      CategoryDM(
        "business",
        "business",
        !isDarkMode ? AppAssets.businessDark : AppAssets.businessLight,
      ),
      CategoryDM(
        "sports",
        "sports",
        !isDarkMode ? AppAssets.sportDark : AppAssets.sportLight,
      ),
      CategoryDM(
        "technology",
        "technology",
        !isDarkMode ? AppAssets.technologyDark : AppAssets.technologyLight,
      ),
      CategoryDM(
        "entertainment",
        "entertainment",
        !isDarkMode
            ? AppAssets.entertainmentDark
            : AppAssets.entertainmentLight,
      ),
      CategoryDM(
        "health",
        "health",
        !isDarkMode ? AppAssets.healthDark : AppAssets.healthLight,
      ),
      CategoryDM(
        "science",
        "science",
        !isDarkMode ? AppAssets.scienceDark : AppAssets.scienceLight,
      ),
    ];
  }
}
