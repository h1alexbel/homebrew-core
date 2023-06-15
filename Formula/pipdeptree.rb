class Pipdeptree < Formula
  include Language::Python::Virtualenv

  desc "CLI to display dependency tree of the installed Python packages"
  homepage "https://github.com/tox-dev/pipdeptree"
  url "https://files.pythonhosted.org/packages/df/42/73bc02a5d135b2268a6c6b9b52198670ae447f027387c913710076d1617a/pipdeptree-2.9.2.tar.gz"
  sha256 "60ff48585f6fc6e283c41893a618faf4deb77b84781c45a3da29bf0c8e0ce4a7"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "689505ab1e42ab5ba8efc3a99aed4c2ca04d21564822c7c39541c4c06db3152a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "892468f9634b17f85e0a8e8eee6a1e9cc8e1ad876dc801597d6f3df7b36b4177"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3abf0580f324228b4c5966c52380734345264281d2a3fffb2d212bf0e915d048"
    sha256 cellar: :any_skip_relocation, ventura:        "b30b3613441fa01a0663e7a79ecd373d8b6effa9b2189bf3f9eaee1e403af5ca"
    sha256 cellar: :any_skip_relocation, monterey:       "4ab0542c85169fa275a9f7ab6cd3f3d09c5bf0c6e2c8ff5523cd357f614b102a"
    sha256 cellar: :any_skip_relocation, big_sur:        "3c0a0143ccaa755b9fd2ea24f125645fa190224ce809b0f3e6e66ca9977d50b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "352aa997cff68d36d33270412b0fc1417ab9957b99dad502d5b1f1b247c36357"
  end

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "pipdeptree==#{version}", shell_output("#{bin}/pipdeptree --all")

    assert_empty shell_output("#{bin}/pipdeptree --user-only").strip

    assert_equal version.to_s, shell_output("#{bin}/pipdeptree --version").strip
  end
end
