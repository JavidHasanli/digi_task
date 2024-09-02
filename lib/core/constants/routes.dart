enum AppRoutes {
  splash(path: '/', name: 'splash'),
  onboarding(path: '/onboarding', name: 'onboarding'),
  login(path: '/login', name: 'login'),
  home(path: '/home', name: 'home'),
  notification(path: 'notification', name: 'notification'),
  anbar(path: 'anbar', name: 'anbar'),
  anbarMain(path: 'anbarMain', name: 'anbarMain'),
  isciler(path: 'isciler', name: 'isciler'),
  chat(path: 'chat', name: 'chat'),
  createTask(path: 'createTask', name: 'createTask'),
  profile(path: 'profile', name: 'profile'),
  events(path: 'events', name: 'events'),
  profileEdit(path: 'profileEdit', name: 'profileEdit'),
  chatDetails(path: 'chatDetails', name: 'chatDetails');


  const AppRoutes({required this.path, required this.name});
  final String path;
  final String name;
}
