enum NavRoute {
  main("/"),
  homeCam("/home"),
  news("/news"),
  detailNews("/news/detail");


  const NavRoute(this.route);
  final String route;
}