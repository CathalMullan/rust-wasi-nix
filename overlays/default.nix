final: prev: {
  rust-wasi-nix = prev.callPackage ../pkgs/rust-wasi-nix { };

  wasi-sdk = prev.callPackage ../pkgs/wasi-sdk { };

  pkgsCross = prev.pkgsCross // {
    wasi32 = prev.pkgsCross.wasi32 // {
      buildPackages = prev.pkgsCross.wasi32.buildPackages // {
        rustc = prev.pkgsCross.wasi32.buildPackages.rustc.override {
          rustc-unwrapped = prev.pkgsCross.wasi32.buildPackages.rustc.unwrapped.overrideAttrs (_: {
            LD_LIBRARY_PATH = "${final.llvmPackages.libunwind}/lib";
            WASI_SDK_PATH = "${final.wasi-sdk}";
          });

          sysroot = prev.buildEnv {
            name = "rustc-sysroot";
            paths = [
              final.pkgsCross.wasi32.buildPackages.rustc.unwrapped
              final.llvmPackages.libunwind
            ];
          };
        };

        cargo = prev.pkgsCross.wasi32.buildPackages.cargo.override {
          inherit (final.pkgsCross.wasi32.buildPackages) rustc;
        };
      };

      rustPlatform = prev.pkgsCross.wasi32.makeRustPlatform {
        inherit (final.pkgsCross.wasi32.buildPackages) cargo rustc;
      };
    };
  };
}
