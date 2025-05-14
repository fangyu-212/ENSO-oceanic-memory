# ENSO-oceanic-memory
This repository contains the code used to get the experiments for "ENSO cycles mostly after extreme El Niño events" by Liu et al. 2025, submitted to Nature.

# Description
To build an ocean modelling methodology which allows to isolate ”oceanic memory” driving ENSO phase transition, here we use NEMO ocean model to conduct control run and memory experiments. The heat flux damping is computed interactively via linear relaxation to climatological SST. 

The contribution of atmospheric linearities is quantified by replacing the total wind stress forcing as its linear part, and the the contribution of atmospheric nonlinearities is gained by subtracting the linear contribution from the total contribution. The linear wind stress forcing is isolated from Srinivas et al. 2024. 

The details for experiments are as follows:

**Control run**
* eOR1-IA-FLX-14: forcing with total observed 3h interannual wind stress variations, 1958-2018
* eOR1-IA-FLX-11: forcing with linear observed 3h interannual wind stress variations, 1980-2018

**Memory experiments**
* eOR1-IA-FLX-29: branch from eOR1-IA-FLX-14 every January 1st, replacing wind stresses with climatological values (i.e., no wind anomalies), 61 members in total.
  * E.g., eOR1-IA-FLX-29-ensemble-01, eOR1-IA-FLX-29-ensemble-02,..., eOR1-IA-FLX-29-ensemble-61 is the exp restarted from 1958 Dec, 1959 Dec,..., 2018 Dec.
* eOR1-IA-FLX-30: branch from eOR1-IA-FLX-11 every January 1st, replacing wind stresses with climatological values (i.e., no wind anomalies), 39 members in total.
  * E.g., eOR1-IA-FLX-30-ensemble-01, eOR1-IA-FLX-30-ensemble-02,..., eOR1-IA-FLX-30-ensemble-61 is the exp restarted from 1980 Dec, 1981 Dec,..., 2018 Dec.

Please cite: Fangyu, F. J. Vialard, S. Han, Y. Planton, M. Lengaigne, G. Srinivas, S. Zhao, E. Guilyardi, W. Zhang, C. Ethé, R. Person, A. Voldoire, F.-F. Jin, A. V. Fedorov and M. J. McPhaden, 2025: ENSO cycles mostly after extreme El Niño events. Submitted to Nature.

# Instructions
NEMO environment & IPSL tools are needed, submit every job by using "ccc_msub Job*". 

Please contact fangyu.liu@locean.ipsl.fr for more details.
