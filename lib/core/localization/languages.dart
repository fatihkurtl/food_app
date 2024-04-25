import 'package:get/get.dart';

final List<Map<String, String>> languages = [
  {"title": "English", "code": "en", "country": "US"},
  {"title": "Turkish", "code": "tr", "country": "TR"}
];

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "tr_TR": {
          // appbar
          "recipe_app": "TARİF UYGULAMASI",
          // home
          "populer_recipes": "POPÜLER TARİFLER",
          "recipes": "TARİFLER",
          "see_all": "Tümünü Gör",
          // drawer
          "light": "Aydınlık",
          "dark": "Karanlık",
          "language": "Dil",
          // bottom navigation
          "home": "Anasayfa",
          "_recipes": "Tarifler",
          "profile": "Profil",
          // recipes cards
          "save": "Kaydet",
          "share": "Paylaş",
          // recipes search bar
          "search_recipes": "Tariflerde ara...",
          // recipes categories
          "main_meals": "Ana Yemekler",
          "soups": "Çorbalar",
          "salads": "Salatalar",
          "breakfast_foods": "Kahvaltılıklar",
          "desserts": "Tatlılar",
          "drinks": "İçecekler",
          "vegan_vegetarian": "Vegan / Vejetaryen",
          "pastas": "Makarnalar",
          "world_cuisines": "Dünya Mutfakları",
          "healthy_recipes": "Sağlıklı Tarifler",
          // profiles
          "saved_recipes": "Kayıtlı Tarifler",
          "edit_profile": "Profili Düzenle",
          // edit profile
          "name": "Ad Soyad",
          "email": "E-posta",
          "gender": "Cinsiyet",
          "age": "Yaş",
          "male": "Erkek",
          "female": "Kadın",
          "other": "Diğer",
        },
        "en_US": {
          // appbar
          "recipe_app": "RECIPE APP",
          // home
          "populer_recipes": "POPULAR RECIPES",
          "recipes": "RECIPES",
          "see_all": "See All",
          // drawer
          "light": "Light",
          "dark": "Dark",
          "language": "Language",
          // bottom navigation
          "home": "Home",
          "_recipes": "Recipes",
          "profile": "Profile",
          // recipes cards
          "save": "Save",
          "share": "Share",
          // recipes search bar
          "search_recipes": "Search in recipes...",
          // recipes categories
          "main_meals": "Main Meals",
          "soups": "Soups",
          "salads": "Salads",
          "breakfast_foods": "Breakfast Foods",
          "desserts": "Desserts",
          "drinks": "Drinks",
          "vegan_vegetarian": "Vegan / Vegetarian",
          "pastas": "Pastas",
          "world_cuisines": "World Cuisines",
          "healthy_recipes": "Healthy Recipes",
          // profiles
          "saved_recipes": "Saved Recipes",
          "edit_profile": "Edit Profile",
          // edit profile
          "name": "Name Surname",
          "email": "E-mail",
          "gender": "Gender",
          "age": "Age",
          "male": "Male",
          "female": "Female",
          "other": "Other",
        },
      };
}
