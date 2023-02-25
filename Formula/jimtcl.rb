class Jimtcl < Formula
  desc "Small footprint implementation of Tcl"
  homepage "http://jim.tcl.tk/index.html"
  url "https://github.com/msteveb/jimtcl/archive/0.82.tar.gz"
  sha256 "e8af929b815e4d30e54ff116b2b933e56c00a02b9110529d1a58660b2469aea7"
  license "BSD-2-Clause"

  bottle do
    sha256 arm64_ventura:  "5321ca61c00bae61155f8d7a4a6abf91d491f5dd7e627092b2fb200d08cce243"
    sha256 arm64_monterey: "82285abcd9d5a13cf8e0d1731aa4264d228229dde326d6177e9bce929fb32a9c"
    sha256 arm64_big_sur:  "0ee14e7cebf6c60666a28d04b7e27cc5ce2f085f7ee0dbb9299842869f2dd8ea"
    sha256 ventura:        "470113fc5affb8ca59af84456c772738ffbcd083d942e3f61d1aa705c43cf4e7"
    sha256 monterey:       "d56d56810fbee5428e98522f2aadb7301e9fdb18f7fc23e6d7ca28043c11555e"
    sha256 big_sur:        "2d72063f3c5525f61ef02ac050ed04d4d9aa56b413185fe1d5f6946b8fb41fc5"
    sha256 catalina:       "8cc4a39c25b1e60ef0c8d77d6144eb40f7b937b3c862277b4ed3edb5fc20bc66"
    sha256 x86_64_linux:   "011dcf9066667d0128c44db11e115f1f9636fae1ad9ab28a7a7ea6158096b7a6"
  end

  depends_on "openssl@3"
  depends_on "readline"

  uses_from_macos "sqlite"
  uses_from_macos "zlib"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--full",
                          "--with-ext=readline,rlprompt,sqlite3",
                          "--shared",
                          "--docdir=#{doc}",
                          "--maintainer",
                          "--math",
                          "--ssl",
                          "--utf8"
    system "make"
    system "make", "install"
    pkgshare.install Dir["examples*"]
  end

  test do
    (testpath/"test.tcl").write "puts {Hello world}"
    assert_match "Hello world", shell_output("#{bin}/jimsh test.tcl")
  end
end
