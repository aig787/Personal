#Moves bash_history to bash_config at a regular interval
#and erases current bash_history
echo "Changing bash_history update rate..."
echo "PROMPT_COMMAND='history -a'" >> ~/.bashrc
echo "Setting bash_profile to bashrc..."
echo "source ~/.bashrc"  >> ~/.bash_profile
source ~/.bashrc
sudo chattr +i ~/.bashrc
echo "Watching bash_history..."
while [ true ]; do
	cat ~/.bash_history
	cat ~/.bash_history >> ~/.bash_config
	 > ~/.bash_history
	sleep 2
done
