{
  nixosModule = { ... }: {
    services.earlyoom = {
      enable = true;
    };
  };

  homeModule = { ... }: {
    services.systembus-notify.enable = true;
  };
}