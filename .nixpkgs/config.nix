{
  packageOverrides = pkgs: rec {
    haskellPackages = with pkgs.haskellPackages; pkgs.haskellPackages // rec {
      xmlPicklers = callPackage ./haskell/xml-picklers.nix {};
      sdl2-image = callPackage ./haskell/sdl2-image.nix {};
      hsSDL2 = callPackage ./haskell/hsSDL2/default.nix {};
      hsSDL2-image = callPackage ./haskell/hsSDL2-image.nix { inherit hsSDL2; };
      hsSDL2-ttf = callPackage ./haskell/hsSDL2-ttf.nix { inherit hsSDL2; };
      wrench = callPackage ./haskell/wrench.nix { inherit hsSDL2; inherit hsSDL2-image; inherit hsSDL2-ttf; };
    };
  };
}
