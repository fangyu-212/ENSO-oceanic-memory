# ENSO-oceanic-memory
This repository contains the code used to get the experiments for "ENSO cycles mostly after extreme El Niño events" by Liu et al. 2025, submitted to Nature.

# Description

Please cite: Fangyu, F. J. Vialard, S. Han, Y. Planton, M. Lengaigne, G. Srinivas, S. Zhao, E. Guilyardi, W. Zhang, C. Ethé, R. Person, A. Voldoire, F.-F. Jin, A. V. Fedorov and M. J. McPhaden, 2025: ENSO cycles mostly after extreme El Niño events. Submitted to Nature.

# Files
**Control run**
* eOR1-IA-FLX-14: forcing with total observed 3h interannual wind stress variations, 1958-2018
* eOR1-IA-FLX-11: forcing with linear observed 3h interannual wind stress variations, 1980-2018

**Memory experiments**
* eOR1-IA-FLX-29: restarted from every Dec ocean condition from eOR1-IA-FLX-14, 61 members in total.
  * E.g., eOR1-IA-FLX-29-ensemble-01, eOR1-IA-FLX-29-ensemble-02,..., eOR1-IA-FLX-29-ensemble-61 is the exp restarted from 1958 Dec, 1959 Dec,..., 2018 Dec.
* eOR1-IA-FLX-30: restarted from every Dec ocean condition from eOR1-IA-FLX-11, 39 members in total.
  * E.g., eOR1-IA-FLX-30-ensemble-01, eOR1-IA-FLX-30-ensemble-02,..., eOR1-IA-FLX-30-ensemble-61 is the exp restarted from 1980 Dec, 1981 Dec,..., 2018 Dec.


# Instructions
NEMO environment is needed, submit every job by using "ccc_msub Job*".
