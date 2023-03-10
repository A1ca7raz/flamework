secret:
	./scripts/update_sops_secrets

disko:
	nix --experimental-features 'nix-command flakes' build .#nixosConfigurations.${PRF}.config.system.build.disko

update:
	curl -L https://raw.githubusercontent.com/a1ca7raz/nurpkgs/main/flake.lock -O
	sudo nixos-rebuild switch --flake .#${PRF}