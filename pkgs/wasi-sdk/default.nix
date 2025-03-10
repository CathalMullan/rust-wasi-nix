{
  lib,
  stdenv,
  pkgsCross,
}:

# A mock wasi-sdk, which mimics the real thing just enough for rustc to build.

stdenv.mkDerivation {
  name = "wasi-sdk";
  version = pkgsCross.wasi32.wasilibc.version;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/wasi-sysroot/lib/wasm32-wasip1
    cp -r ${pkgsCross.wasi32.wasilibc}/lib/* $out/share/wasi-sysroot/lib/wasm32-wasip1
  '';

  meta = {
    description = "WASI SDK for compiling C/C++ to WebAssembly.";
    homepage = "https://github.com/WebAssembly/wasi-sdk";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
