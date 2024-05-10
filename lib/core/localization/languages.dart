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
          "sign_in": "Giriş Yap",
          "sign_up": "Kayıt Ol",
          "logout": "Çıkış Yap",
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
          // sign up & sign in
          "create_an_account_to_continue": "Devam etmek için hesap oluşturun",
          "password": "Şifre",
          "confirm_password": "Şifreyi Onayla",
          "already_have_an_account": "Zaten hesabınız var mı? ",
          "sign_in_to_continue": "Devam etmek için giriş yapın",
          "dont_have_an_account": "Hesabınız yok mu? ",
          // sign up warning snackbar
          "error": "Hata",
          "please_fill_in_the_required_fields": "Lütfen gerekli alanları doldurunuz",
          "passwords_do_not_match": "Şifreler eşleşmiyor",
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
          "sign_in": "Sign In",
          "sign_up": "Sign Up",
          "logout": "Logout",
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
          "name": "Full Name",
          "email": "E-mail",
          "gender": "Gender",
          "age": "Age",
          "male": "Male",
          "female": "Female",
          "other": "Other",
          // sign up & sign in
          "create_an_account_to_continue": "Create an account to continue",
          "password": "Password",
          "confirm_password": "Confirm Password",
          "already_have_an_account": "Already have an account? ",
          "sign_in_to_continue": "Sign in to continue",
          "dont_have_an_account": "Don't have an account? ",
          // sign up warning snackbar
          "error": "Error",
          "please_fill_in_the_required_fields": "Please fill in the required fields",
          "passwords_do_not_match": "Passwords do not match",
        },
      };
}
