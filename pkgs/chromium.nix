{
  buildPackage,
  chromium,
}:

buildPackage {
  name = "chromium";
  inherit (chromium) version;

  app_id = 1;
  id = "org.chromium.Chromium";
  userns = true;
  map_real_uid = true;
  system_bus = {
    filter = true;

    talk = [
      "org.bluez"
      "org.freedesktop.Avahi"
      "org.freedesktop.UPower"
    ];
  };
  session_bus =
    f:
    f {
      talk = [
        "org.freedesktop.FileManager1"
        "org.freedesktop.ScreenSaver"
        "org.freedesktop.secrets"
        "org.kde.kwalletd5"
        "org.kde.kwalletd6"
      ];
      own = [ "org.mpris.MediaPlayer2.chromium.*" ];
      call = { };
      broadcast = { };
    };

  modules = [
    {
      programs.chromium = {
        enable = true;
        package = chromium;
        commandLineArgs = [
          "--ignore-gpu-blocklist"
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
        ];
      };
    }
  ];

  script = ''
    export GOOGLE_API_KEY='AIzaSyBHDrl33hwRp4rMQY0ziRbj8K9LPA6vUCY'
    export GOOGLE_DEFAULT_CLIENT_ID='77185425430.apps.googleusercontent.com'
    export GOOGLE_DEFAULT_CLIENT_SECRET='OTJgUOQcT7lO7GsGZq2G4IlT'
    exec chromium "$@"
  '';
}
