class Startbar < Formula
  desc "Taskbar for macOS with a Start button, window buttons, pinned apps and a clock"
  homepage "https://github.com/pratherbytecraft/startbar"
  url "https://registry.npmjs.org/startbar/-/startbar-0.2.1.tgz"
  sha256 "02aa32e0375ebac99730dda047f9ec7c4ae774515948f1da879da55b9e2504b1"
  license :cannot_represent

  depends_on :macos
  depends_on "node"

  def install
    # Startbar's install builds its Swift helper, and Electron's downloads
    # the Electron app, so the package scripts have to run.
    system "npm", "install", *std_npm_args(ignore_scripts: false)
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Start it with:
        startbar
      The first run sets up Startbar.app in ~/Applications, so it can be
      opened again from Spotlight, and asks for the Accessibility permission.
    EOS
  end

  test do
    assert_path_exists libexec/"lib/node_modules/startbar/helper/startbar-helper"
  end
end
