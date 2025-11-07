{
  description = "Neovim config flake";

  outputs = { self, ... }: {

    defaultPackage = {
      x86_64-linux = self;
      aarch64-linux = self;
      x86_64-darwin = self;
      aarch64-darwin = self;
    };

    homeFiles = {
      nvimConfig = {
        source = ./.;
        recursive = true;
      };
    };
  };
}

