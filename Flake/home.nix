{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "stoics";
  home.homeDirectory = "/home/stoics";

  home.packages = with pkgs; [
    # User related packages
    vesktop # Alt discord
    fastfetch # Alt neofetch
    newsboat # RSS feed
    keepassxc # Password manager
    r2modman # Mod manager
    mullvad-vpn # VPN application with gui
    zathura # PDF reader
    mpv # Mediaplayer
    qbittorrent # Torrent application
    hugo # building website, on my main station for testing.
    xfce.thunar # file manager
  ];

  # Hx editor
  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn_night_transparent";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      }
    ];
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };

  # VR (WiVRn is in ./configuration.nix)
  imports = [ ./opencomposite.nix ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
