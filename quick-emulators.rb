class QuickEmulators < Formula
  desc "Launch your Android emulators (Genymotion and AVDs) via Spotlight: ⌘ + Space"
  homepage "https://github.com/dvoiss/quick-emulators"
  url "https://github.com/dvoiss/quick-emulators/archive/0.1.1.tar.gz"
  version "0.1.1"
  sha256 "13c96c259ed7ab4744dd44751552d05ae7895be13cf3f04e834c52106d0261ed"

  def install
    FileUtils.mv "quick-emulators.py", "quickemulators"
    bin.install "quickemulators"
  end

  def caveats
    <<-EOS.undent
      - To test Quick Emulators, create a new Genymotion emulator or Android virtual device,
        after creating search Spotlight with the name of the emulator. The default keys to
        activate Spotlight are Command + Space.

      - To remove the launching daemon, use the following commands:

          sudo launchctl unload -w /Library/LaunchDaemons/com.dvoiss.quickemulators.plist
          sudo rm /Library/LaunchDaemons/com.dvoiss.quickemulators.plist

      - Usage with Android Virtual Devices requires a "ANDROID_SDK" or "ANDROID_HOME" environment
        variable that is used to get the path to the emulator in the tools directory.

      - Usage with Genymotion Emulators requires "Genymotion.app" installed under "Applications".

      - ** Make sure to install the daemon to this location **

          ln -sfv /usr/local/opt/quick-emulators/*plist /Library/LaunchDaemons
          sudo launchctl load /Library/LaunchDaemons/com.dvoiss.quickemulators.plist
    EOS
  end

  def plist_name
    "com.dvoiss.quickemulators"
  end

  def plist
    <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>com.dvoiss.quickemulators</string>
        <key>EnableGlobbing</key>
        <true/>
        <key>ProgramArguments</key>
        <array>
            <string>/usr/local/opt/quick-emulators/bin/quickemulators</string>
        </array>
        <key>WatchPaths</key>
        <array>
          <string>~/.android/avd/</string>
          <string>~/.Genymobile/Genymotion/deployed/</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
    EOS
  end

  test do
    system "quickemulators", "version"
  end
end
