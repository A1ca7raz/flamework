{ ... }:
let
  colorBar = "[40m [41m [42m [43m [44m [45m [46m [47m [100m [101m [102m [103m [104m [105m [106m [107m [40m [41m [42m [43m [44m [45m [46m [47m [100m [101m [102m [103m [104m [105m [106m [107m [0m";
in {
  users.motd = ''
      #================================================#
      #                     WARNING                    #
      #  Unauthorized personnel accessing this system  #
      #         will be TERMINATED IMMEDIATELY         #
      #================================================#

    Welcome to A1ca7raz's Private Network!

    ${colorBar}

  '';
}