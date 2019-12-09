class Gnuplot < Formula
  desc "Command-driven, interactive function plotting"
  homepage "http://www.gnuplot.info/"
  url "https://downloads.sourceforge.net/project/gnuplot/gnuplot/5.2.7/gnuplot-5.2.7.tar.gz"
  sha256 "97fe503ff3b2e356fe2ae32203fc7fd2cf9cef1f46b60fe46dc501a228b9f4ed"
  revision 1

  bottle do
    sha256 "e1da5191c494e45bc6b899baa87094d588bbd659abf348d91341480be02eea05" => :catalina
    sha256 "c5f7eb8ca16ddc90c9c14f100c43c46c5be179dc1389bf85e1d7726dd862c6d7" => :mojave
    sha256 "4f09ccc4c4bf56c65873e20f7265df44fcbec3e319592a2d6870ee3a06a60dfa" => :high_sierra
    sha256 "33c03c8bff2e427d6c2b25575de43b8c41041919b79c320b1a57a8de23cb5d7d" => :sierra
  end

  head do
    url "https://git.code.sf.net/p/gnuplot/gnuplot-main.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  option "with-cairo", "Build the Cairo based terminals"
  option "without-lua", "Build without the lua/TikZ terminal"
  option "with-wxmac", "Build wxmac support. Need with-cairo to build wxt terminal"
  option "with-aquaterm", "Build with AquaTerm support"

  deprecated_option "with-x" => "with-x11"
  deprecated_option "wx" => "with-wxmac"
  deprecated_option "qt" => "with-qt"
  deprecated_option "with-qt5" => "with-qt"
  deprecated_option "cairo" => "with-cairo"
  deprecated_option "nolua" => "without-lua"

  depends_on "pkg-config" => :build
  depends_on "gd"
  depends_on "readline"
  depends_on "lua" => :recommended
  depends_on "qt" => :optional
  depends_on "wxmac" => :optional
  depends_on "pango" if build.with?("cairo") || build.with?("wxmac")
  depends_on :x11 => :optional

  def install
    # Qt5 requires c++11 (and the other backends do not care)
    ENV.cxx11

    if build.with? "aquaterm"
      # Add "/Library/Frameworks" to the default framework search path, so that an
      # installed AquaTerm framework can be found. Brew does not add this path
      # when building against an SDK (Nov 2013).
      ENV.prepend "CPPFLAGS", "-F/Library/Frameworks"
      ENV.prepend "LDFLAGS", "-F/Library/Frameworks"
    end

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-readline=#{Formula["readline"].opt_prefix}
      --without-tutorial
    ]

    if build.without? "wxmac"
      args << "--disable-wxwidgets"
      args << "--without-cairo" if build.without? "cairo"
    end

    if build.with? "qt"
      args << "--with-qt"
    else
      args << "--with-qt=no"
    end

    args << "--without-lua" if build.without? "lua"
    args << (build.with?("aquaterm") ? "--with-aquaterm" : "--without-aquaterm")
    args << (build.with?("x11") ? "--with-x" : "--without-x")

    system "./prepare" if build.head?
    system "./configure", *args
    ENV.deparallelize # or else emacs tries to edit the same file with two threads
    system "make"
    system "make", "install"
  end

  def caveats
    if build.with? "aquaterm"
      <<~EOS
      AquaTerm support will only be built into Gnuplot if the standard AquaTerm
      package from SourceForge has already been installed onto your system.
      If you subsequently remove AquaTerm, you will need to uninstall and then
      reinstall Gnuplot.
      EOS
    end
  end

  test do
    system "#{bin}/gnuplot", "-e", <<~EOS
    set terminal dumb;
    set output "#{testpath}/graph.txt";
    plot sin(x);
    EOS
    assert_predicate testpath/"graph.txt", :exist?
  end
end
