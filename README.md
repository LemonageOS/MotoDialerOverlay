# MotoDialerOverlay
An RRO to make the MotoDialer theming process faster and simpler

## Setup
1. Clone this repository to internal storage using HTTPS
```
cd ~/storage/shared && git clone https://github.com/LemonageOS/MotoDialerOverlay.git
```
> [!TIP]  
> You may need to run `termux-setup-storage` first

2. Add an alias for the signing script
```
bash MotoDialerOverlay/utils/add_alias.sh
```
> [!TIP]  
> Do not forget to reload the bashrc manually after running the above command

3. Run said script using the alias you just created and solve all errors.  
Once done, you should see the message _The overlay has been signed successfully_

4. Enable the overlay using one of the commands below  

on PC
```
adb shell cmd overlay enable com.lemonage.mdoverlay
```

on Android
```
su -c cmd overlay enable com.lemonage.mdoverlay
```

## Contribute
1. Change directory to MotoDialerOverlay
```
cd ~/storage/shared/MotoDialerOverlay
```
2. Remove the HTTPS remote
```
git remote rm origin
```

3. Add an SSH remote
```
git remote add origin git@github.com:LemonageOS/MotoDialerOverlay.git
```
> [!TIP]  
> It is strongly recommended that you contribute using your PC since you have to re-add your SSH key to the ssh-agent each time you start a new Termux session
