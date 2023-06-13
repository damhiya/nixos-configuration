{ ... }: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # firefox
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/chrome" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-extension-shtml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "application/x-extension-xhtml" = "firefox.desktop";
      "application/x-extension-xht" = "firefox.desktop";

      # okular
      "application/pdf" = "okularApplication_pdf.desktop";
      "image/bnd.djvu" = "okularApplication_djvu.desktop";

      # nomacs
      "image/png" = "org.nomacs.ImageLounge.desktop";
      "image/bmp" = "org.nomacs.ImageLounge.desktop";
      "image/jpeg" = "org.nomacs.ImageLounge.desktop";
      "image/gif" = "org.nomacs.ImageLounge.desktop";
      "image/tiff" = "org.nomacs.ImageLounge.desktop";
    };
  };
}
