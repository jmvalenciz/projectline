all:
	@echo "Use one of this options:"
	@echo "    - make install (to install)"
	@echo "    - make config (to create a new config file with default config)"
	@echo "    - make uninstall (to uninstall the prorgam)"

install:
	@if ! command -v fd &> /dev/null ;then echo "fd not found";exit 1;fi;
	@if ! command -v fzf &> /dev/null ;then echo "fzf not found";exit 1;fi;
	@chmod +x projectline.sh
	@cp projectline.sh ~/.local/bin/projectline
	@echo "projectline installed successfully!"

config:
	@mkdir -pv ~/.config/projectline
	@cp -v config.sh ~/.config/projectline
	@echo "default config installed"

uninstall:
	@rm -r ~/.local/bin/projectline
	@echo "projectline uninstalled successfully"
