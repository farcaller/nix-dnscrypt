{
  description = "dnscrypt docker image packaged from nixpkgs";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    with import nixpkgs { system = "x86_64-linux"; };
    {
      dockerImage = pkgs.dockerTools.buildImage {
        name = "dnscrypt";
        tag = "latest";

        copyToRoot = pkgs.buildEnv {
          name = "dnscrypt";
          paths = [ pkgs.dnscrypt-proxy2 ];
          pathsToLink = [ "/bin" ];
        };

        config = {
          Entrypoint = [ "/bin/dnscrypt-proxy" ];
          Command = [ "-config" "/etc/dnscrypt-proxy/config.toml" ];
        };
      };
    };
}
