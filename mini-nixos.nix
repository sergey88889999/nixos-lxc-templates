#==============================================================
# NixOS LXC Container Template for Proxmox
#==============================================================
# - Access: Root access via SSH key (password disabled)
# - Networking: Host-managed (configured via Proxmox/OpenTofu)
# - Packages: Minimal toolset (vim-full, git, curl, mc, btop)
# - Time zone configuration Europe/Berlin
#==============================================================

{ pkgs, modulesPath, ... }: {
  imports = [
    "${modulesPath}/virtualisation/lxc-container.nix"
  ];

  services.resolved.enable = false;

  networking = {
    hostName = "nixos-lxc";
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };

  users.users.root.openssh.authorizedKeys.keyFiles = [
    ./ssh-keys/control-node.pub
  ];

  time.timeZone = "Europe/Berlin"; 
  documentation.enable = false;

  environment.systemPackages = with pkgs; [
    vim-full
    git
    curl
    btop
    mc
  ];

  system.stateVersion = "25.11"; 
}
