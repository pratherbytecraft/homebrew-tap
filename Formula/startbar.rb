class Startbar < Formula
  desc "Taskbar for macOS with a Start button, window buttons, pinned apps and a clock"
  homepage "https://github.com/pratherbytecraft/startbar"
  url "https://registry.npmjs.org/startbar/-/startbar-0.2.6.tgz"
  sha256 "68ef882619f83461063e6ccf53d785f752843cb38fa1abca2551ca7b67ace38b"
  license :cannot_represent

  depends_on :macos
  depends_on "node"

  def install
    # Startbar's install builds its Swift helper, so the package scripts have
    # to run. Electron's app is left out: Homebrew would try to rewrite its
    # libraries and fail, and Startbar doesn't need it here, since the first
    # run downloads it and builds Startbar.app in ~/Applications from it.
    ENV["ELECTRON_SKIP_BINARY_DOWNLOAD"] = "1"
    system "npm", "install", *std_npm_args(ignore_scripts: false)
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Start it with:
        startbar
      The first run downloads Electron and sets up Startbar.app in
      ~/Applications, so it can be opened again from Spotlight, and asks for
      the Accessibility permission.
    EOS
  end

  test do
    assert_path_exists libexec/"lib/node_modules/startbar/helper/startbar-helper"
  end
end
