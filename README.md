# Nix-Darwin Configuration

Modular nix-darwin configuration for personal and professional MacBooks.

## Structure

```
.
├── flake.nix                    # Main flake entry point
├── modules/
│   └── shared.nix              # Shared configuration for all hosts
└── hosts/
    ├── personal/
    │   └── default.nix         # Personal MacBook configuration
    └── professional/
        └── default.nix         # Professional MacBook configuration
```

## Features

- **Touch ID for sudo**: Use Touch ID for sudo authentication
- **Auto-hide menu bar**: Menu bar automatically hides
- **Modular configuration**: Separate configs for personal and work machines
- **Shared base**: Common packages and settings across all machines

## Usage

### First-time setup

1. Install Xcode Command Line Tools:
   ```sh
   xcode-select --install
   ```
2. Create the project directory and enter it:
   ```sh
   mkdir -p ~/project/github/clement-fouque
   cd ~/project/github/clement-fouque
   ```
3. Clone the repository and enter it:
   ```sh
   git clone https://github.com/clement-fouque/nix-darwin
   cd nix-darwin
   ```
4. Install Nix ([docs](https://nixos.org/download/)), for example:
   ```sh
   curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh
   ```
5. Open a new terminal (or reload your shell) so `nix` is on your `PATH`.
6. Apply the configuration. Choose the flake that matches this machine.
   **Warning:** both hosts enable Homebrew `cleanup = "zap"`, which may remove undeclared Homebrew packages/casks. Only run this on a machine you are OK managing via this flake.
   ```sh
   # Professional MacBook
   sudo nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#professional

   # Personal MacBook
   sudo nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#personal
   ```
   The `darwin-rebuild` command is not available until after the first run; afterwards, use it as in [Switching configurations](#switching-configurations) below.

### Switching configurations

For personal MacBook:

```sh
sudo darwin-rebuild switch --flake .#personal
```

For professional MacBook:

```sh
sudo darwin-rebuild switch --flake .#professional
```

### Dynamic host detection (optional)

You can set your hostname to match the configuration name:

```sh
# Set hostname to match your config
sudo scutil --set HostName personal
# or
sudo scutil --set HostName professional

# Then rebuild with just:
sudo darwin-rebuild switch --flake .
```

## Customization

### Adding packages

- **Shared packages**: Edit `modules/shared.nix`
- **Personal packages**: Edit `hosts/personal/default.nix`
- **Work packages**: Edit `hosts/professional/default.nix`

### Adding new hosts

1. Create a new directory: `hosts/NEW_HOSTNAME/`
2. Create `hosts/NEW_HOSTNAME/default.nix`
3. Add configuration in `flake.nix`:
   ```nix
   darwinConfigurations."NEW_HOSTNAME" = mkDarwinSystem "NEW_HOSTNAME";
   ```

## Common Commands

```sh
# Update flake inputs
nix flake update

# Check what will change
sudo darwin-rebuild build --flake .#personal
sudo darwin-rebuild build --flake .#professional

# Apply changes
sudo darwin-rebuild switch --flake .#personal
sudo darwin-rebuild switch --flake .#professional

# Rollback to previous generation
sudo darwin-rebuild --rollback
```
