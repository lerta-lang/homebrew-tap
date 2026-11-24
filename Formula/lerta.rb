class Lerta < Formula
  desc "Statically typed language that compiles to native code through LLVM"
  homepage "https://lerta.org/"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  release = "https://github.com/lerta-lang/lerta/releases/download/v#{version}"

  on_macos do
    on_arm do
      url "#{release}/lerta-#{version}-macos-arm64.tar.gz"
      sha256 "374efc5c6ef7e0f99028e08702727b46e240677875ceca7d3b5c940321ec789e"
    end
    on_intel do
      url "#{release}/lerta-#{version}-macos-amd64.tar.gz"
      sha256 "571535a9938dc4abdd289016ff87532f4a5291b0b45a9e6578b2ef0d23cae1f2"
    end
  end

  on_linux do
    on_arm do
      url "#{release}/lerta-#{version}-linux-arm64.tar.gz"
      sha256 "0e27a9b3852565f068ecebe4981ced73fc026da5f080f2751d594695a6d12a18"
    end
    on_intel do
      url "#{release}/lerta-#{version}-linux-amd64.tar.gz"
      sha256 "eae5cb3a32479a126837be2b143fbe04f233be0aa07c585b9dd47649a9fe48e1"
    end
  end

  def install
    bin.install "lerta"
  end

  def caveats
    on_linux do
      <<~EOS
        lerta builds programs with clang (LLVM 15 or newer), GNU ld and the
        C library's development files: install them with the system's packages.
      EOS
    end
  end

  test do
    (testpath/"hello.lerta").write "print 'hello, world'\n"
    assert_equal "hello, world\n", shell_output("#{bin}/lerta run hello.lerta")
  end
end
