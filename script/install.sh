#!/bin/zsh

# Get Github username from user
echo "Please, enter your Github username:"
read GITHUB_USERNAME

# Set global variables
GITHUB_DOMAIN="https://github.com"
COMMIT_PICS_REPO_URL="$GITHUB_DOMAIN/$GITHUB_USERNAME/commitpics"
GIT_COMMIT_PICS_PATH="$HOME/.git-commitpics"
GIT_COMMIT_PICS_SCRIPT_PATH="$GIT_COMMIT_PICS_PATH/script/post-commit.sh"
GIT_TEMPLATES_PATH="$HOME/.git-templates"
GIT_HOOKS_PATH="$GIT_TEMPLATES_PATH/hooks"
GIT_COMMIT_SCRIPT_PATH="$GIT_HOOKS_PATH/post-commit"

# Make sure all the brew dependencies are met
BREW_DEPS=( imagesnap imagemagick )

echo "\nChecking for \`brew\` dependencies:\n "
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
echo "\nCloning $COMMIT_PICS_REPO_URL to $GIT_COMMIT_PICS_PATH..."
# git clone $COMMIT_PICS_REPO_URL $GIT_COMMIT_PICS_PATH || exit 1;

# Create hooks
echo "Creating $GIT_HOOKS_PATH..."
if [[ ! -d  $GIT_HOOKS_PATH ]] ; then
	mkdir -p $GIT_HOOKS_PATH
fi

# Symlink the post-commit script
echo "Symlinking $GIT_COMMIT_PICS_SCRIPT_PATH to $GIT_COMMIT_SCRIPT_PATH..."
# ln -s $GIT_COMMIT_PICS_SCRIPT_PATH $GIT_COMMIT_SCRIPT_PATH || exit 1

echo \
"\nCongratulation! git-commitpics is now ready to be used!
\`cd\` to a directory you want to track with commit pics and simply run:
	\`git init\`
You should be ready to go!"
