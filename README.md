# Chezmoi: Custom `.bashrc` Setup

This repository contains a Chezmoi template to generate a customized `.bashrc` file based on `/etc/skel/.bashrc`. It removes commented lines and automatically sources additional files like `.shell_aliases` and `.shellrc` if they exist.

## Key Features

1. **Filter Out Commented Lines**:
   - The generated `.bashrc` file removes all lines starting with `#` (comments) from `/etc/skel/.bashrc`.

2. **Automatic Loading of Additional Files**:
   - If `~/.shell_aliases` exists, it is automatically sourced in the `.bashrc`.
   - If `~/.shellrc` exists, it is also automatically sourced.

3. **Cross-Platform Compatibility**:
   - The template works on both Linux and macOS -working_on_it- systems.

## Repository Structure

- `dot_bashrc.tmpl`: Chezmoi template to generate the `.bashrc` file.
- `Brewfile`: contains brew formulas for macOS
- `Debfile`: contains the apt packages for Debian Linux
- `run_onchange_Debfile.tmpl`: where we install the minimal packages and magic happens.
 
## Usage

1. **Install Chezmoi**:
   If you don't have Chezmoi installed, you can install it with the following command:

   ```bash
   sh -c "$(curl -fsLS chezmoi.io/get)"
   ``` 	

	and:

	```bash
   chezmoi init https://github.com/vicendominguez/dotfiles-chezmoi.git
	```
