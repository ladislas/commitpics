#!/bin/zsh

# Get Github username from user
echo "Please, enter your Github username:"
read GITHUB_USERNAME

# Set global variables
GITHUB_DOMAIN="https://github.com"
COMMIT_PICS_REPO_URL="$GITHUB_DOMAIN/$GITHUB_USERNAME/commitpics"
GIT_COMMIT_PICS_PATH="$HOME/.git-commitpics-test"
GIT_COMMIT_PICS_SCRIPT_PATH="$GIT_COMMIT_PICS_PATH/script/post-commit.sh"
GIT_TEMPLATES_PATH="$HOME/.git-templates"
GIT_HOOKS_PATH="$GIT_TEMPLATES_PATH/hooks"
GIT_COMMIT_SCRIPT_PATH="$GIT_HOOKS_PATH/post-commit"

# Make sure all the brew dependencies are met
BREW_DEPS=( imagesnap imagemagick )

for dep in "${BREW_DEPS[@]}"
do
	if brew ls --version $dep &> /dev/null ; then
		echo "Looking for $dep........ OK"
	else
		echo "Looking for $dep........ Error, not found!"
		exit 1
	fi
done

# Clone commitpics/commitpics to ~/.git-commit pics
echo "Cloning the repository..."
git clone $COMMIT_PICS_REPO_URL $GIT_COMMIT_PICS_PATH || exit 1;

# Create hooks
echo "Creating ~/.git-templates/hooks..."
if [[ ! -d  $GIT_HOOKS_PATH ]] ; then
	mkdir -p $GIT_HOOKS_PATH
fi

# Symlink the post-commit script
echo "Symlinking the post-commit script..."
ln -s $GIT_COMMIT_PICS_SCRIPT_PATH $GIT_COMMIT_SCRIPT_PATH || exit 1

echo "End of the script"
