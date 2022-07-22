class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.54.0.tgz"
  sha256 "e47a1e370f78990f1f6f3047a86f166ea6184f3a4e37193b16df08f9950b555b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "180e1250d8439a68e2ea90220e13067629285ece9fede81e6ac3ad8712738be4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "180e1250d8439a68e2ea90220e13067629285ece9fede81e6ac3ad8712738be4"
    sha256 cellar: :any_skip_relocation, monterey:       "180e1250d8439a68e2ea90220e13067629285ece9fede81e6ac3ad8712738be4"
    sha256 cellar: :any_skip_relocation, big_sur:        "180e1250d8439a68e2ea90220e13067629285ece9fede81e6ac3ad8712738be4"
    sha256 cellar: :any_skip_relocation, catalina:       "180e1250d8439a68e2ea90220e13067629285ece9fede81e6ac3ad8712738be4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3c7d7b9fd0da0b7692cd701a359e1e2482966f8eeb9a981676b3c6ee851041a4"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.scss").write <<~EOS
      div {
        img {
          border: 0px;
        }
      }
    EOS

    assert_equal "div img{border:0px}",
    shell_output("#{bin}/sass --style=compressed test.scss").strip
  end
end
