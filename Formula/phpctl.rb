class Phpctl < Formula
  desc "It is a Docker (containers) based development environment for PHP"
  homepage "https://phpctl.dev"
  url "https://github.com/opencodeco/phpctl.git", using: :git, branch: "main"
  version "latest"
  license "MIT"

  depends_on "coreutils"
  depends_on "git"

  uses_from_macos "ruby"

  def install
    srcdir_name = "src"
    libexec.install Dir["bin/*"]

    mkdir_p "#{prefix}/#{srcdir_name}"
    cp_r "#{buildpath}/#{srcdir_name}", prefix

    bin.install_symlink "#{libexec}/phpctl"
  end

  test do
    output = shell_output("#{libexec}/phpctl doctor")
    assert_match "PHP_VERSION", output
    assert_match "PHPCTL_IMAGE", output
    assert_match "PHPCTL_RUNTIME", output
    assert_match "PHPCTL_USER", output
  end
end
