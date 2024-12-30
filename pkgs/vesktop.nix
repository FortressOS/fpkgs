{
  buildPackage,
  vesktop,
}:

buildPackage {
  name = "vesktop";
  inherit (vesktop) version;

  app_id = 8;
  id = "dev.vencord.Vesktop";
  userns = true;
  map_real_uid = true;
  system_bus.filter = true;
  session_bus =
    f:
    f {
      talk = [ "org.kde.StatusNotifierWatcher" ];
      own = [ ];
      call = { };
      broadcast = { };
    };

  modules = [ { home.packages = [ vesktop ]; } ];

  script = ''
    exec /.fortify/nixGL/nixGL vesktop --ozone-platform-hint=wayland "$@"
  '';
}
