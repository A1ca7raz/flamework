{
  nixosModule = { user, ... }: {
    # user: (optional) current username
    # ...
  };

  homeModule = { ... }: {
    # Note: Argument home is unnecessary here.
    # ...
  };
}
