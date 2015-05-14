{ cabal,fetchgit,SDL2,SDL2_ttf,hsSDL2 }:

cabal.mkDerivation (self: {
  src = fetchgit {
    url = https://github.com/pmiddend/hsSDL2-ttf.git;
    rev = "2f6c9a2b9b53be05e676422c1eb7176db1ed10dd";
    sha256 = "03f582db9swvxqgk28fswxvnnl1fm5048jdpi2py2cccnw4yci40";
  };
  pname = "hsSDL2-ttf";
  version = "0.1.0";
  buildDepends = [ hsSDL2 SDL2 ];
  pkgconfigDepends = [ SDL2 SDL2_ttf ];
  meta = {
    description = "Support for SDL2_ttf library";
    license = self.stdenv.lib.licenses.publicDomain;
    platforms = self.ghc.meta.platforms;
  };
})
