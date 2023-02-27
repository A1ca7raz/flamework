secret:
	./scripts/update_sops_secrets

disko:
	nix --experimental-features 'nix-command flakes' build .#nixosConfigurations.${PRF}.config.system.build.disko