# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

# Заряды для потенциала Jakse из таблицы I
set type 1 charge 1.890   # Кремний
set type 2 charge -0.945 # Кислород

pair_style born/coul/long 10.0
pair_coeff 1 1 0.001198 0.0460 1.4408 25.153 0.0   # Si-Si
pair_coeff 1 2 0.006990 0.1560 2.5419 46.226 0.0   # Si-O
pair_coeff 2 2 0.011980 0.2630 3.6430 84.966 0.0   # O-O

kspace_style pppm 1.0e-4

# Setup neighbor style
neighbor 1.0 nsq
neigh_modify once no every 1 delay 0 check yes

# Setup minimization style
min_style	     cg
min_modify	     dmax ${dmax} line quadratic

# Setup output
thermo		1
thermo_style custom step temp pe press pxx pyy pzz pxy pxz pyz lx ly lz vol
thermo_modify norm no
