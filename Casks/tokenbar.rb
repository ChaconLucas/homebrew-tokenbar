cask "tokenbar" do
  version "0.4.0"
  sha256 "b1f65683e7da254b3425b5695c31d2fa1eafe60c58cf050181d0f324e8f9a780"

  url "https://github.com/ChaconLucas/tokenbar/releases/download/v#{version}/TokenBar-macOS.zip"
  name "TokenBar"
  desc "AI usage limits (Claude Code, Codex, any AI) on an LED dot-matrix display"
  homepage "https://github.com/ChaconLucas/tokenbar"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sequoia

  app "TokenBar.app"

  # O app ainda não é autenticado pela Apple: sem isso o macOS bloqueia a primeira abertura.
  # O Homebrew avisa que `postflight` vai mudar, mas ainda não há passo declarativo para isso.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/TokenBar.app"]
  end

  zap trash: [
    "~/.tokenbar",
    "~/Library/Preferences/dev.chacon.tokenbar.mac.plist",
  ]
end
