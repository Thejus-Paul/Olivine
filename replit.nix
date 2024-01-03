{ pkgs }: {
  deps = [
    pkgs.redis
    pkgs.postgresql_13
    pkgs.yarn
    pkgs.ruby_3_1
    pkgs.rubyPackages_3_1.solargraph
  ];
}
