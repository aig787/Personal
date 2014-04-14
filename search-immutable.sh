#Searched important directories for immutable files
echo "Checking for immutable files in /etc/..."
sudo lsattr -R /etc 2>/dev/null | grep "\-i-"
echo "Checking for immutable files in /usr/bin/..."
sudo lsattr -R /usr/bin 2>/dev/null | grep "\-i-"
echo "Checking for immutable files in /home/..."
sudo lsattr -R /home 2>/dev/null | grep "\-i-"
#Takes a really long time to complete for entire filesystem
#echo "Searching filesystem for immutable files..."
#sudo lsattr -R / 2>/dev/null | grep "\-i-"
