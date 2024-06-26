{ inputs, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.firefox;
in {
    options.modules.firefox = { enable = mkEnableOption "firefox"; };

    config = mkIf cfg.enable {
        programs.firefox = {
            enable = true;

            profiles.curiouslad.isDefault = true;
            profiles.curiouslad.name = "curiouslad";

            # Install extensions from NUR
            profiles.curiouslad.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                ublock-origin
                sponsorblock
                darkreader
                h264ify
                df-youtube
            ];

            # Privacy about:config settings
            profiles.curiouslad = {
                settings = {
                    "dom.event.clipboardevents.enabled" = true;
                    "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
                    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

                    # Disable telemetry
                    #"browser.newtabpage.activity-stream.feeds.telemetry" = false;
                    #"browser.ping-centre.telemetry" = false;
                    #"browser.tabs.crashReporting.sendReport" = false;
                    #"devtools.onboarding.telemetry.logged" = false;
                    #"toolkit.telemetry.enabled" = false;
                    #"toolkit.telemetry.unified" = false;
                    #"toolkit.telemetry.server" = "";

                    # Disable Pocket
                    "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
                    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
                    "browser.newtabpage.activity-stream.showSponsored" = false;
                    "extensions.pocket.enabled" = false;

                    # Harden SSL 
                    #"security.ssl.require_safe_negotiation" = true;

                    # Extra
                    "browser.search.suggest.enabled" = false;
                    "browser.urlbar.suggest.bookmark" = false;
                    "browser.urlbar.suggest.engines" = false;
                    "browser.urlbar.suggest.history" = false;
                    "browser.urlbar.suggest.openpage" = false;
                    "browser.urlbar.suggest.topsites" = false;
                    "browser.uidensity" = 1;
                    "media.autoplay.enabled" = false;
                    "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2";
                    
                    #"network.http.sendRefererHeader" = 0;
                };

                # userChome.css to make it look better
                # userChrome = "
                #     * { 
                #         box-shadow: none !important;
                #         border: 0px solid !important;
                #     }

                #     #tabbrowser-tabs {
                #         --user-tab-rounding: 8px;
                #     }

                #     .tab-background {
                #         border-radius: var(--user-tab-rounding) var(--user-tab-rounding) 0px 0px !important; /* Connected */
                #         margin-block: 1px 0 !important; /* Connected */
                #     }
                #     #scrollbutton-up, #scrollbutton-down { /* 6/10/2021 */
                #         border-top-width: 1px !important;
                #         border-bottom-width: 0 !important;
                #     }

                #     .tab-background:is([selected], [multiselected]):-moz-lwtheme {
                #         --lwt-tabs-border-color: rgba(0, 0, 0, 0.5) !important;
                #         border-bottom-color: transparent !important;
                #     }
                #     [brighttext='true'] .tab-background:is([selected], [multiselected]):-moz-lwtheme {
                #         --lwt-tabs-border-color: rgba(255, 255, 255, 0.5) !important;
                #         border-bottom-color: transparent !important;
                #     }

                #     /* Container color bar visibility */
                #     .tabbrowser-tab[usercontextid] > .tab-stack > .tab-background > .tab-context-line {
                #         margin: 0px max(calc(var(--user-tab-rounding) - 3px), 0px) !important;
                #     }

                #     #TabsToolbar, #tabbrowser-tabs {
                #         --tab-min-height: 29px !important;
                #     }
                #     #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar, 
                #     #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar #tabbrowser-tabs {
                #         --tab-min-height: 30px !important;
                #     }
                #     #scrollbutton-up,
                #     #scrollbutton-down {
                #         border-top-width: 0 !important;
                #         border-bottom-width: 0 !important;
                #     }

                #     #TabsToolbar, #TabsToolbar > hbox, #TabsToolbar-customization-target, #tabbrowser-arrowscrollbox  {
                #         max-height: calc(var(--tab-min-height) + 1px) !important;
                #     }
                #     #TabsToolbar-customization-target toolbarbutton > .toolbarbutton-icon, 
                #     #TabsToolbar-customization-target .toolbarbutton-text, 
                #     #TabsToolbar-customization-target .toolbarbutton-badge-stack,
                #     #scrollbutton-up,#scrollbutton-down {
                #         padding-top: 7px !important;
                #         padding-bottom: 6px !important;
                #     }
                # ";
            };
          };


      };

}
