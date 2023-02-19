{ pkgs, ... }:
let
  tide = pkgs.fishPlugins.tide.src;
in
{
  programs.fish = {
    enable = true;
    plugins = [{
      name = "tide";
      src = tide;
    }];

    shellInit = ''
      set -U fish_greeting

      function fish_user_key_bindings
        fish_vi_key_bindings
        bind f accept-autosuggestion
      end

      string replace -r '^' 'set -U ' < ${tide}/functions/tide/configure/configs/lean.fish         | source
      string replace -r '^' 'set -U ' < ${tide}/functions/tide/configure/configs/lean_16color.fish | source
      set -U tide_prompt_add_newline_before false

      set -U __fish_initialized 3400
      set -U _tide_left_items vi_mode\x1eos\x1epwd\x1egit
      set -U _tide_prompt_62118 \x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b37m\ue0b2\x1b\x5b30m\x1b\x5b47m\x20\uf313\x20\x1b\x5b37m\x1b\x5b44m\ue0b0\x1b\x5b44m\x20\x40PWD\x40\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b34m\ue0b0\x1e\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b30m\ue0b2\x1b\x5b32m\x1b\x5b40m\x20\u2714\x20\x1b\x5b37m\x1b\x5b40m\ue0b2\x1b\x5b30m\x1b\x5b47m\x2019\x3a55\x3a13\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b37m\ue0b0
      set -U _tide_right_items status\x1ecmd_duration\x1econtext\x1ejobs\x1enix_shell\x1etime
      set -U fish_color_autosuggestion 707A8C
      set -U fish_color_cancel \x2d\x2dreverse
      set -U fish_color_command 5CCFE6
      set -U fish_color_comment 5C6773
      set -U fish_color_cwd 73D0FF
      set -U fish_color_cwd_root red
      set -U fish_color_end F29E74
      set -U fish_color_error FF3333
      set -U fish_color_escape 95E6CB
      set -U fish_color_history_current \x2d\x2dbold
      set -U fish_color_host normal
      set -U fish_color_host_remote \x1d
      set -U fish_color_keyword \x1d
      set -U fish_color_match F28779
      set -U fish_color_normal CBCCC6
      set -U fish_color_operator FFCC66
      set -U fish_color_option \x1d
      set -U fish_color_param CBCCC6
      set -U fish_color_quote BAE67E
      set -U fish_color_redirection ff5fd7
      set -U fish_color_search_match \x2d\x2dbackground\x3dFFCC66
      set -U fish_color_selection \x2d\x2dbackground\x3dFFCC66
      set -U fish_color_status red
      set -U fish_color_user brgreen
      set -U fish_color_valid_path \x2d\x2dunderline
      set -U fish_key_bindings fish_default_key_bindings
      set -U fish_pager_color_background \x1d
      set -U fish_pager_color_completion normal
      set -U fish_pager_color_description B3A06D
      set -U fish_pager_color_prefix normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
      set -U fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan
      set -U fish_pager_color_secondary_background \x1d
      set -U fish_pager_color_secondary_completion \x1d
      set -U fish_pager_color_secondary_description \x1d
      set -U fish_pager_color_secondary_prefix \x1d
      set -U fish_pager_color_selected_background \x2d\x2dbackground\x3dFFCC66
      set -U fish_pager_color_selected_completion \x1d
      set -U fish_pager_color_selected_description \x1d
      set -U fish_pager_color_selected_prefix \x1d
      set -U tide_aws_bg_color yellow
      set -U tide_aws_color brblack
      set -U tide_aws_icon \uf270
      set -U tide_character_color brgreen
      set -U tide_character_color_failure brred
      set -U tide_character_icon \u276f
      set -U tide_character_vi_icon_default \u276e
      set -U tide_character_vi_icon_replace \u25b6
      set -U tide_character_vi_icon_visual V
      set -U tide_chruby_bg_color red
      set -U tide_chruby_color black
      set -U tide_chruby_icon \ue23e
      set -U tide_cmd_duration_bg_color yellow
      set -U tide_cmd_duration_color black
      set -U tide_cmd_duration_decimals 0
      set -U tide_cmd_duration_icon \uf252
      set -U tide_cmd_duration_threshold 3000
      set -U tide_context_always_display false
      set -U tide_context_bg_color brblack
      set -U tide_context_color_default yellow
      set -U tide_context_color_root yellow
      set -U tide_context_color_ssh yellow
      set -U tide_context_hostname_parts 1
      set -U tide_crystal_bg_color brwhite
      set -U tide_crystal_color black
      set -U tide_crystal_icon \u2b22
      set -U tide_docker_bg_color blue
      set -U tide_docker_color black
      set -U tide_docker_default_contexts default\x1ecolima
      set -U tide_docker_icon \uf308
      set -U tide_git_bg_color green
      set -U tide_git_bg_color_unstable yellow
      set -U tide_git_bg_color_urgent red
      set -U tide_git_color_branch black
      set -U tide_git_color_conflicted black
      set -U tide_git_color_dirty black
      set -U tide_git_color_operation black
      set -U tide_git_color_staged black
      set -U tide_git_color_stash black
      set -U tide_git_color_untracked black
      set -U tide_git_color_upstream black
      set -U tide_git_icon \uf1d3
      set -U tide_git_truncation_length 24
      set -U tide_go_bg_color brcyan
      set -U tide_go_color black
      set -U tide_go_icon \ue627
      set -U tide_java_bg_color yellow
      set -U tide_java_color black
      set -U tide_java_icon \ue256
      set -U tide_jobs_bg_color brblack
      set -U tide_jobs_color green
      set -U tide_jobs_icon \uf013
      set -U tide_kubectl_bg_color blue
      set -U tide_kubectl_color black
      set -U tide_kubectl_icon \u2388
      set -U tide_left_prompt_frame_enabled false
      set -U tide_left_prompt_items vi_mode\x1eos\x1epwd\x1egit
      set -U tide_left_prompt_prefix \ue0b2
      set -U tide_left_prompt_separator_diff_color \ue0b0
      set -U tide_left_prompt_separator_same_color \ue0b1
      set -U tide_left_prompt_suffix \ue0b0
      set -U tide_nix_shell_bg_color brblue
      set -U tide_nix_shell_color black
      set -U tide_nix_shell_icon \uf313
      set -U tide_node_bg_color green
      set -U tide_node_color black
      set -U tide_node_icon \u2b22
      set -U tide_os_bg_color white
      set -U tide_os_color black
      set -U tide_os_icon \uf313
      set -U tide_php_bg_color blue
      set -U tide_php_color black
      set -U tide_php_icon \ue608
      set -U tide_private_mode_bg_color brwhite
      set -U tide_private_mode_color black
      set -U tide_private_mode_icon \ufaf8
      set -U tide_prompt_add_newline_before true
      set -U tide_prompt_color_frame_and_connection brblack
      set -U tide_prompt_color_separator_same_color brblack
      set -U tide_prompt_icon_connection \x20
      set -U tide_prompt_min_cols 34
      set -U tide_prompt_pad_items true
      set -U tide_pwd_bg_color blue
      set -U tide_pwd_color_anchors brwhite
      set -U tide_pwd_color_dirs brwhite
      set -U tide_pwd_color_truncated_dirs white
      set -U tide_pwd_icon \uf07c
      set -U tide_pwd_icon_home \uf015
      set -U tide_pwd_icon_unwritable \uf023
      set -U tide_pwd_markers \x2ebzr\x1e\x2ecitc\x1e\x2egit\x1e\x2ehg\x1e\x2enode\x2dversion\x1e\x2epython\x2dversion\x1e\x2eruby\x2dversion\x1e\x2eshorten_folder_marker\x1e\x2esvn\x1e\x2eterraform\x1eCargo\x2etoml\x1ecomposer\x2ejson\x1eCVS\x1ego\x2emod\x1epackage\x2ejson
      set -U tide_right_prompt_frame_enabled false
      set -U tide_right_prompt_items status\x1ecmd_duration\x1econtext\x1ejobs\x1enode\x1evirtual_env\x1erustc\x1ejava\x1ephp\x1echruby\x1ego\x1ekubectl\x1etoolbox\x1eterraform\x1eaws\x1enix_shell\x1ecrystal\x1etime
      set -U tide_right_prompt_prefix \ue0b2
      set -U tide_right_prompt_separator_diff_color \ue0b2
      set -U tide_right_prompt_separator_same_color \ue0b3
      set -U tide_right_prompt_suffix \ue0b0
      set -U tide_rustc_bg_color red
      set -U tide_rustc_color black
      set -U tide_rustc_icon \ue7a8
      set -U tide_shlvl_bg_color yellow
      set -U tide_shlvl_color black
      set -U tide_shlvl_icon \uf120
      set -U tide_shlvl_threshold 1
      set -U tide_status_bg_color black
      set -U tide_status_bg_color_failure red
      set -U tide_status_color green
      set -U tide_status_color_failure bryellow
      set -U tide_status_icon \u2714
      set -U tide_status_icon_failure \u2718
      set -U tide_terraform_bg_color magenta
      set -U tide_terraform_color black
      set -U tide_terraform_icon \x1d
      set -U tide_time_bg_color white
      set -U tide_time_color black
      set -U tide_time_format \x25T
      set -U tide_toolbox_bg_color magenta
      set -U tide_toolbox_color black
      set -U tide_toolbox_icon \u2b22
      set -U tide_vi_mode_bg_color_default white
      set -U tide_vi_mode_bg_color_insert cyan
      set -U tide_vi_mode_bg_color_replace green
      set -U tide_vi_mode_bg_color_visual yellow
      set -U tide_vi_mode_color_default black
      set -U tide_vi_mode_color_insert black
      set -U tide_vi_mode_color_replace black
      set -U tide_vi_mode_color_visual black
      set -U tide_vi_mode_icon_default D
      set -U tide_vi_mode_icon_insert I
      set -U tide_vi_mode_icon_replace R
      set -U tide_vi_mode_icon_visual V
      set -U tide_virtual_env_bg_color brblack
      set -U tide_virtual_env_color cyan
      set -U tide_virtual_env_icon \ue73c
    '';
  };
}