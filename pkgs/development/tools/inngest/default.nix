{ lib, fetchurl, stdenv }:

let
  ver = "0.29.3";
  platformDetails = platform:
    {
      "aarch64-darwn" = {
        url =
          "https://github.com/inngest/inngest/releases/download/v${ver}/inngest_${ver}_darwin_amd64.tar.gz";
        sha256 =
          "967abdd6f85c6b7ef7938f6062826b096911ee6f4a121b2401735420965ce51c";
      };
      "x86_64-darwin" = {
        url =
          "https://github.com/inngest/inngest/releases/download/v${ver}/inngest_${ver}_darwin_arm64.tar.gz";
        sha256 =
          "ce776430a997189be337ebe82a310d1e5bb35b382d82864ca05e6edd40456ade";
      };
      "aarch64-linux" = {
        url =
          "https://github.com/inngest/inngest/releases/download/v${ver}/inngest_${ver}_linux_arm64.tar.gz";
        sha256 =
          "c9657b569c0cb901586526951288db7867707b60cac63776fcfb34f99dd3b136";
      };
      "x86_64-linux" = {
        url =
          "https://github.com/inngest/inngest/releases/download/v${ver}/inngest_${ver}_linux_amd64.tar.gz";
        sha256 =
          "47b72f28b84515fa7ec2370d9fb50d1a2a48b868b5744f6e4f2218f1eb73fd53";
      };
      "aarch64-windows" = {
        url =
          "https://github.com/inngest/inngest/releases/download/v${ver}/inngest_${ver}_windows_arm64.zip";
        sha256 =
          "63356dfac4a0153fc23a07c78f89414581decfbf6f65c9bcdc00dc2fbf6e134e";
      };
      "x86_64-windows" = {
        url =
          "https://github.com/inngest/inngest/releases/download/v${ver}/inngest_${ver}_windows_amd64.zip";
        sha256 =
          "f0e84f747bbca42aadb166abb9a096eace29049d41ebe8b341937c367d546898";
      };
    }."${platform}";

in stdenv.mkDerivation rec {
  pname = "inngest";
  version = ver;

  # select the appropriate platform details
  inherit (platformDetails stdenv.system) url sha256;

  src = fetchurl { inherit url sha256; };
  sourceRoot = ".";

  # TODO: windows probably need a different installation phase
  installPhase = ''
    mkdir -p $out/bin
    cp inngest $out/bin/
  '';

  meta = with lib; {
    description = "Inngest CLI";
    homepage = "https://www.inngest.com/";
    license = licenses.sspl;
    maintainers = with maintainers; [ darwin67 albertchae ];
    downloadPage = "https://github.com/inngest/inngest/releases";
    mainProgram = "inngest";
    platforms = platforms.linux ++ platforms.darwin ++ platforms.windows;
  };
}
