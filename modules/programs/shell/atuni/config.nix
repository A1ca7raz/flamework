{
  update_check = false;
  filter_mode = "host";
  search_mode = "fulltext";
  style = "compact";
  enter_accept = true;
  show_tabs = false;

  stats = {
    common_subcommands = [
      "cargo"
      "git"
      "go"
      "ip"
      "nix"
      "deno"
      "npm"
      "pnpm"
      "yarn"
      "systemctl"
      "tmux"
    ];
    common_prefix = [ "sudo" ];
  };
  
  sync.records = true;
}