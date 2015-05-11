{ cabal, SDL2, text, time, vector, fetchgit }:

cabal.mkDerivation (self: {
  src = fetchgit {
    url = https://github.com/pmiddend/hsSDL2.git;
    rev = "74c08436b44003803116484f108af91b9cc838ca";
    sha256 = "1cpiyfpdwg9lp337afaqmwzvjj06isdh3zrkwb0r6sl1p2c8lgmf";
  };

  pname = "hsSDL2";
  version = "0.1.0";
  buildDepends = [ text time vector ];
  extraLibraries = [ SDL2 ];
  meta = {
    description = "Binding to libSDL2";
    license = self.stdenv.lib.licenses.publicDomain;
    platforms = self.ghc.meta.platforms;
  };
})
