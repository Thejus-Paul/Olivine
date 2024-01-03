{ pkgs }: {
  deps = [
    pkgs.postgresql_14
    pkgs.redis
    pkgs.yarn
    pkgs.ruby_3_2
    pkgs.rubyPackages_3_2.solargraph
  ];
}
