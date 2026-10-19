class Shotdrawer < Formula
  desc "Menu bar app for macOS that lists your recent screenshots and copies their paths"
  homepage "https://github.com/pratherbytecraft/shotdrawer"
  url "https://registry.npmjs.org/shotdrawer/-/shotdrawer-0.1.0.tgz"
  sha256 "fcd511fe9527a61a08e2e63981a441dc13ffbe31f77a6be22606544339d668bb"
  license :cannot_represent

  depends_on :macos
  depends_on "node"

  def install
    # Electron's app is left out: Homebrew would try to rewrite its libraries
    # and fail, and Shotdrawer doesn't need it here, since the first run
    # downloads it and builds Shotdrawer.app in ~/Applications from it.
    ENV["ELECTRON_SKIP_BINARY_DOWNLOAD"] = "1"
    system "npm", "install", *std_npm_args(ignore_scripts: false)
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Start it with:
        shotdrawer
      The first run downloads Electron and sets up Shotdrawer.app in
      ~/Applications, so it can be opened again from Spotlight. It lives in
      the menu bar and asks for access to your screenshot folder.
    EOS
  end

  test do
    assert_path_exists libexec/"lib/node_modules/shotdrawer/dist/main/index.js"
  end
end
