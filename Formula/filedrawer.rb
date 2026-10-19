class Filedrawer < Formula
  desc "File manager for macOS with tabs, two panes, a typed address bar and a task pane"
  homepage "https://github.com/pratherbytecraft/filedrawer"
  url "https://registry.npmjs.org/filedrawer/-/filedrawer-0.1.0.tgz"
  sha256 "8491628b26d2a1fdb26a0f8efca6c8984f162cd6a48a2192c68d04aad197562d"
  license :cannot_represent

  depends_on :macos
  depends_on "node"

  def install
    # Filedrawer's install builds its Swift helper, and Electron's downloads
    # the Electron app, so the package scripts have to run.
    system "npm", "install", *std_npm_args(ignore_scripts: false)
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Start it with:
        filedrawer
      The first run sets up Filedrawer.app in ~/Applications, so it can be
      opened again from Spotlight, and asks for the permissions it needs to
      open folders in place of Finder.
    EOS
  end

  test do
    assert_path_exists libexec/"lib/node_modules/filedrawer/helper/filedrawer-helper"
  end
end
