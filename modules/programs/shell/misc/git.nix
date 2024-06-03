# Git (Global)
{ ... }: {
  programs.git.enable = true;
  programs.git.config = {
    init.defaultBranch = "main";
    core.editor = "vim";
  };
}