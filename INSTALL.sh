curl -s https://get.sdkman.io > sdkman.sh
less sdkman.sh
echo "OK?"
read
bash sdkman.sh
source $HOME/.sdkman/bin/sdkman-init.sh
sdk install ceylon
