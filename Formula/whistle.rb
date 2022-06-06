require "language/node"

class Whistle < Formula
  desc "HTTP, HTTP2, HTTPS, Websocket debugging proxy"
  homepage "https://github.com/avwo/whistle"
  url "https://registry.npmjs.org/whistle/-/whistle-2.9.20.tgz"
  sha256 "4f7fc5f8a97631ee91ea13d6bf121c9b662adfebc87938d0a54db686aa2ddbca"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "eb3f98660e986268ef07fa6935370eb8a9885356dfe132d74c9686062b91bb81"
  end

  # `bin/proxy/mac/Whistle` was only built for `x86_64`
  # upstream issue tracker, https://github.com/avwo/whistle/issues/734
  depends_on arch: :x86_64
  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"package.json").write('{"name": "test"}')
    system bin/"whistle", "start"
    system bin/"whistle", "stop"
  end
end
