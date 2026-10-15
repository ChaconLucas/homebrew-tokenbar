cask "tokenbar" do
  version "0.3.7"
  sha256 "1d1bdda9ecb464379ef6ccf071f2425feac06e1a47c0daa7bf07dd20afa03cd4"

  url "https://github.com/ChaconLucas/tokenbar/releases/download/v#{version}/TokenBar-macOS.zip"
  name "TokenBar"
  desc "AI usage limits (Claude Code, Codex, any AI) on an LED dot-matrix display"
  homepage "https://github.com/ChaconLucas/tokenbar"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :sequoia"

  app "TokenBar.app"

  # O app ainda não é autenticado pela Apple: sem isso o macOS bloqueia a primeira abertura.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/TokenBar.app"]
  end

  zap trash: [
    "~/.tokenbar",
    "~/Library/Preferences/dev.chacon.tokenbar.mac.plist",
  ]
end
