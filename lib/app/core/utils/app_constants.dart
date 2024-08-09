import 'package:purple_planet_packaging/app/features/custom_print/model/app_faq_model.dart';

class AppConstants {
  static String baseUrl = 'https://purpleplanetpackaging.co.uk/';

  AppConstants._();

  static const List<AppFAQ> appFaqs = [
    AppFAQ(
        question: 'What is Lorem Ipsum?',
        answer:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
  ];
}
