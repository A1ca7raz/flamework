{ ... }:
{
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  # programs.zsh = {
  #   enable = true;
  #   histFile = "$HOME/.cache/zsh_history";

  #   vteIntegration = true;
  #   enableBashCompletion = true;
  #   autosuggestions.enable = true;
  #   syntaxHighlighting.enable = true;
  # };
}