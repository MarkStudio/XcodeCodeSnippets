#! /bin/bash

snippets_path="~/Library/Developer/Xcode/UserData/CodeSnippets"
# echo $snippets_path
if [ -d "$snippets_path" ]; then
  # backup the CodeSnippets in the local Xcode
  mv ~/Library/Developer/Xcode/UserData/CodeSnippets ~/Library/Developer/Xcode/UserData/CodeSnippets.backup
# this is delete the CodeSnippets in the local Xcode
# rm ~/Library/Developer/Xcode/UserData/CodeSnippets
fi

# link the git source directory to the Xcode directory
# 'pwd' means "Print Working Directory"
SRC_HOME=$(pwd)
REAL_SNIPPTES_PATH=${SRC_HOME}/CodeSnippets
echo "Current Snippets Real Path : $REAL_SNIPPTES_PATH"

ln -s ${REAL_SNIPPTES_PATH} ~/Library/Developer/Xcode/UserData/CodeSnippets

echo "Code Snippets has been linked!!! (by mark)"


