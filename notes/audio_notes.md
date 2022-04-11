# Check Audio Settings
alsamixer

## Show possible audio cards
```
cat /proc/asound/cards
```

## Set Default Audio Device
create file:
```
/etc/asound.conf
```
Enter following entries:
Replace 1 with the number of the card determined 
```
defaults.pcm.card 1
defaults.ctl.card 1
```
