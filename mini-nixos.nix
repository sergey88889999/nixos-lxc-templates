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
  
  # DISABLE NixOS network management
  networking = {
    hostName = "nixos-lxc";
    
    # Critically important!
    useDHCP = lib.mkForce false;
    useNetworkd = lib.mkForce true;
    interfaces = lib.mkForce {};  # Empty interface set
    dhcpcd.enable = lib.mkForce false;
  };

  # Enable systemd-networkd WITHOUT configuration
  systemd.network = {
    enable = true;
    networks = {};  # Empty! Proxmox will populate this
  };

  # Make /etc/systemd/network writable for Proxmox
  system.activationScripts.lxc-network = lib.stringAfter [ "etc" ] ''
    # Удаляем симлинк созданный NixOS
    rm -rf /etc/systemd/network
    # Создаём обычную директорию
    mkdir -p /etc/systemd/network
    chmod 755 /etc/systemd/network
  '';

  services.resolved.enable = false;

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
