class Bpftop < Formula
  desc "Dynamic real-time view of running eBPF programs"
  homepage "https://github.com/Netflix/bpftop"
  url "https://github.com/Netflix/bpftop/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "d941314d8716f22d009a031de30edc92586cd434646bf2d2eb14c0a42e94bc95"
  license "Apache-2.0"
  head "https://github.com/Netflix/bpftop.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a4a5c979e18395c79bbc4f78d15a9d9ef950213a5d3dda5a9194e3f81b6e58d5"
  end

  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "elfutils"
  depends_on :linux
  depends_on "zlib"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    output = shell_output("#{bin}/bpftop 2>&1", 1)
    assert_match "Error: This program must be run as root", output
  end
end
