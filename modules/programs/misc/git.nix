{
  homeModule = { ... }: {
    programs.git = {
      enable = true;
      userName = "A1ca7raz";
      userEmail = "7345998+A1ca7raz@users.noreply.github.com";
    };
  };

  # Git (Global)
  nixosModule = { ... }: {
    programs.git.enable = true;
    programs.git.config = {
      init.defaultBranch = "main";
      core.editor = "vim";
    };
  };
}