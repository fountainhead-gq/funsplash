class AppLocale {
  static const String titleHome = 'title_home';

  static String titleCollection = 'title_collection';
  static String titleSetting = 'title_setting';
  static String titleAbout = 'title_about';
  static String titleShare = 'title_share';
  static String titleSignOut = 'title_signout';
  static String titleLanguage = 'title_language';
  static String titleTheme = 'title_theme';
  static String titleAuthor = 'title_author';
  static String titleOther = 'title_other';

  static String languageAuto = 'language_auto';
  static String languageZH = 'language_zh';
  static String languageTW = 'language_tw';
  static String languageHK = 'language_hk';
  static String languageEN = 'language_en';

  static String save = 'save';
}

// Map<String, Map<String, String>> localizedSimpleValues = {
//   'en': {
//     AppLocale.titleHome: 'Home',
//     AppLocale.titleRepos: 'Repos',
//     AppLocale.titleEvents: 'Events',
//     AppLocale.titleSystem: 'System',
//     AppLocale.titleBookmarks: 'Bookmarks',
//     AppLocale.titleSetting: 'Setting',
//     AppLocale.titleAbout: 'About',
//     AppLocale.titleShare: 'Share',
//     AppLocale.titleSignOut: 'Sign Out',
//     AppLocale.titleLanguage: 'Language',
//     AppLocale.languageAuto: 'Auto',
//   },
//   'zh': {
//     AppLocale.titleHome: '主页',
//     AppLocale.titleRepos: '项目',
//     AppLocale.titleEvents: '动态',
//     AppLocale.titleSystem: '体系',
//     AppLocale.titleBookmarks: '书签',
//     AppLocale.titleSetting: '设置',
//     AppLocale.titleAbout: '关于',
//     AppLocale.titleShare: '分享',
//     AppLocale.titleSignOut: '注销',
//     AppLocale.titleLanguage: '多语言',
//     AppLocale.languageAuto: '跟随系统',
//   },
// };

Map<String, Map<String, Map<String, String>>> localizedValues = {
  'en': {
    'US': {
      AppLocale.titleHome: 'Home',
      AppLocale.titleCollection: 'Collection',
      AppLocale.titleSetting: 'Setting',
      AppLocale.titleAbout: 'About',
      AppLocale.titleShare: 'Share',
      AppLocale.titleLanguage: 'Language',
      AppLocale.languageAuto: 'Auto',
      AppLocale.titleTheme: 'Theme',
      AppLocale.save: 'Save',
    }
  },
  'zh': {
    'CN': {
      AppLocale.titleHome: '主页',
      AppLocale.titleCollection: '集合',
      AppLocale.titleSetting: '设置',
      AppLocale.titleAbout: '关于',
      AppLocale.titleShare: '分享',
      AppLocale.titleLanguage: '多语言',
      AppLocale.languageAuto: '跟随系统',
      AppLocale.languageZH: '简体中文',
      AppLocale.languageTW: '繁體中文（台灣）',
      AppLocale.languageHK: '繁體中文（香港）',
      AppLocale.languageEN: 'English',
      AppLocale.titleTheme: '主题',
      AppLocale.save: 'Save',
    },
    'HK': {
      AppLocale.titleHome: '主頁',
      AppLocale.titleCollection: '收藏',
      AppLocale.titleSetting: '設置',
      AppLocale.titleAbout: '關於',
      AppLocale.titleShare: '分享',
      AppLocale.titleLanguage: '語言',
      AppLocale.languageAuto: '與系統同步',
      AppLocale.titleTheme: '主題',
      AppLocale.save: 'Save',
    },
    'TW': {
      AppLocale.titleHome: '主頁',
      AppLocale.titleCollection: '收藏',
      AppLocale.titleSetting: '設置',
      AppLocale.titleAbout: '關於',
      AppLocale.titleShare: '分享',
      AppLocale.titleSignOut: '註銷',
      AppLocale.titleLanguage: '語言',
      AppLocale.languageAuto: '與系統同步',
      AppLocale.titleTheme: '主題',
      AppLocale.save: 'Save',
    }
  }
};
