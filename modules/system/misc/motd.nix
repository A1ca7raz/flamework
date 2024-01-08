{ ... }:
let
  colorBar = "[40m [41m [42m [43m [44m [45m [46m [47m [100m [101m [102m [103m [104m [105m [106m [107m [40m [41m [42m [43m [44m [45m [46m [47m [100m [101m [102m [103m [104m [105m [106m [107m [0m";
in {
  users.motd = ''
      #===========================================================#
      #                          [1m[5m[33mWARNING[0m                          #
      #      ANY UNAUTHORIZED PERSONNEL accessing this system     #
      # will be [1m[31mTERMINATED IMMEDIATELY[0m through [93mMEMETIC KILL AGENT[0m #
      #===========================================================#

    Welcome to A1ca7raz's Private Network!

    ${colorBar}

  '';
}