# OFC-I firmware

OFC-I collects data packages from 16 ADCs and sends the assembled one to OFC-II.
Project name: Rx

## Version

2022 Mar 25, v0.05.02 
Recommended Quartus version: v15.0 (64 bit)

## Get started

```
cd existing_repo
git remote add origin https://gitlab.com/c_lin/ofc-i-firmware.git
git branch -M main
git push -uf origin main
```

Always check the agreement between Rx.pin and OFC_ref.pin.
The pin assignment must be kept identical at all times.

## Documents

- [OFC module and the skeleton file](https://edg.uchicago.edu/~bogdan/KOTO_OFC_Module/index.html).
- [OFC-I design](https://sites.google.com/uchicago.edu/koto/daq/ofc-i).


## Authors

- Skeleton version: Mircea Bogdan.
- Preliminary memory design: Qisen Lin.
- Final design: Chieh Lin.

## Contact

Chieh Lin (chiehlin@uchicago.edu)

