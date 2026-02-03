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

1. Install Nix with flakes support
2. Install nix-darwin:
   ```sh
   nix run nix-darwin -- switch --flake .#personal
   ```

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

# Apply changes
sudo darwin-rebuild switch --flake .#personal

# Rollback to previous generation
sudo darwin-rebuild --rollback
```
