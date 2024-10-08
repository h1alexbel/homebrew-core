class Buf < Formula
  desc "New way of working with Protocol Buffers"
  homepage "https://github.com/bufbuild/buf"
  url "https://github.com/bufbuild/buf/archive/refs/tags/v1.38.0.tar.gz"
  sha256 "d45c5037255a1683e156afdd8e48b6a05cae713d138950ce5bc1675964bb2e52"
  license "Apache-2.0"
  head "https://github.com/bufbuild/buf.git", branch: "main"

  # There can be a notable gap between when a version is tagged and a
  # corresponding release is created, so we check the "latest" release instead
  # of the Git tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6ebbcdc8021ec9991295ff2908fa1c9a5b984aacb06b84dc4490cc62c3ede9df"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6ebbcdc8021ec9991295ff2908fa1c9a5b984aacb06b84dc4490cc62c3ede9df"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6ebbcdc8021ec9991295ff2908fa1c9a5b984aacb06b84dc4490cc62c3ede9df"
    sha256 cellar: :any_skip_relocation, sonoma:         "8c434e896187aec1ff95bef92f6fff95b066bdef669a8f459d28e733698e44d4"
    sha256 cellar: :any_skip_relocation, ventura:        "8c434e896187aec1ff95bef92f6fff95b066bdef669a8f459d28e733698e44d4"
    sha256 cellar: :any_skip_relocation, monterey:       "8c434e896187aec1ff95bef92f6fff95b066bdef669a8f459d28e733698e44d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ae38f43bd1e00c06b5bde34ad6daf0cbf18666f7df5f161172bb611f87a80130"
  end

  depends_on "go" => :build

  def install
    %w[buf protoc-gen-buf-breaking protoc-gen-buf-lint].each do |name|
      system "go", "build", *std_go_args(ldflags: "-s -w", output: bin/name), "./cmd/#{name}"
    end

    generate_completions_from_executable(bin/"buf", "completion")
    man1.mkpath
    system bin/"buf", "manpages", man1
  end

  test do
    (testpath/"invalidFileName.proto").write <<~EOS
      syntax = "proto3";
      package examplepb;
    EOS

    (testpath/"buf.yaml").write <<~EOS
      version: v1
      name: buf.build/bufbuild/buf
      lint:
        use:
          - DEFAULT
          - UNARY_RPC
      breaking:
        use:
          - FILE
        ignore_unstable_packages: true
    EOS

    expected = <<~EOS
      invalidFileName.proto:1:1:Filename "invalidFileName.proto" should be \
      lower_snake_case.proto, such as "invalid_file_name.proto".
      invalidFileName.proto:2:1:Files with package "examplepb" must be within \
      a directory "examplepb" relative to root but were in directory ".".
      invalidFileName.proto:2:1:Package name "examplepb" should be suffixed \
      with a correctly formed version, such as "examplepb.v1".
    EOS
    assert_equal expected, shell_output("#{bin}/buf lint invalidFileName.proto 2>&1", 100)

    assert_match version.to_s, shell_output("#{bin}/buf --version")
  end
end
