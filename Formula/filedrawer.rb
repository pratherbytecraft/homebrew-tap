class Filedrawer < Formula
  desc "File manager for macOS with tabs, two panes, a typed address bar and a task pane"
  homepage "https://github.com/pratherbytecraft/filedrawer"
  url "https://registry.npmjs.org/filedrawer/-/filedrawer-0.1.4.tgz"
  sha256 "e32f74d190e315dcbd28f6f4867be640010d18913bb7b0754098eecdfe63bcfb"
  license :cannot_represent

  depends_on :macos
  depends_on "node"

  def install
    # Filedrawer's install builds its Swift helper, so the package scripts have
    # to run. Electron's app is left out: Homebrew would try to rewrite its
    # libraries and fail, and Filedrawer doesn't need it here, since the first
    # run downloads it and builds Filedrawer.app in ~/Applications from it.
    ENV["ELECTRON_SKIP_BINARY_DOWNLOAD"] = "1"
    system "npm", "install", *std_npm_args(ignore_scripts: false)
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Start it with:
        filedrawer
      The first run downloads Electron and sets up Filedrawer.app in
      ~/Applications, so it can be opened again from Spotlight, and asks for
      the permissions it needs to open folders in place of Finder.
    EOS
  end

  test do
    assert_path_exists libexec/"lib/node_modules/filedrawer/helper/filedrawer-helper"
  end
end
