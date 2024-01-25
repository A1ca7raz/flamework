secret:
	./scripts/update_sops_secrets
	git add config/secrets
	git add config/secrets_home
	git commit -m "update secrets"

disko:
	nix --experimental-features 'nix-command flakes' build .#nixosConfigurations.${PRF}.config.system.build.disko

update:
	nix flake update
	sudo nixos-rebuild switch --flake .#${PRF}

bump:
	git add flake.lock
	git commit -m "Bump flake.lock"
