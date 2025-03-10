{
  pkgsCross,
  llvmPackages,
}:

pkgsCross.wasi32.rustPlatform.buildRustPackage {
  name = "rust-wasi-nix";
  version = "0.0.0";

  RUSTFLAGS = "-C linker=${llvmPackages.lld}/bin/lld";

  src = ../../.;

  cargoLock = {
    lockFile = ../../Cargo.lock;
  };
}
