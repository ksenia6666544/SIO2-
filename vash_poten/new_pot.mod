# Параметры решетки кварца
units metal
boundary p p p
atom_style atomic

variable a equal 4.91
variable c equal 5.43
variable a1 equal 0.5*${a}
variable a2 equal sqrt(3.0)/2.0*${a}
variable a3 equal ${c}

# Создание примитивной ячейки кварца
lattice custom 1.0 &
    a1    ${a1} -${a2} 0     &
    a2    ${a1} ${a2}  0     &
    a3    0     0      ${c}  &
    basis 0.531 0      0.333 &
    basis 0     0.531  0.666 &
    basis 0.469 0.469  0     &
    basis 0.269 0.413  0.785 &
    basis 0.587 0.856  0.115 &
    basis 0.144 0.731  0.445 &
    basis 0.413 0.269  0.225 &
    basis 0.856 0.587  0.875 &
    basis 0.731 0.144  0.545

region		box prism 0 2.0 0 3.0 0 4.0 0.0 0.0 0.0
create_box	2 box
create_atoms 1 box basis 1 1 basis 2 1 basis 3 1 &
    basis 4 2 basis 5 2 basis 6 2 basis 7 2 basis 8 2 basis 9 2

# Массы атомов
mass 1 28.0855  # Кремний
mass 2 15.999   # Кислород

# Потенциал Vashishta для SiO2
pair_style vashishta
pair_coeff * * SiO.1997.vashishta Si O

neighbor 1.0 bin
neigh_modify every 1 delay 0 check yes

thermo_style custom step temp pe etotal press vol lx ly lz
thermo 100

dump min_all all custom 10 quartz_minimization1.lammpstrj id type x y z fx fy fz
dump_modify min_all sort id

# Минимизация энергии
minimize 1.0e-10 1.0e-10 10000 10000

write_dump all custom quartz_minimized1.lammpstrj id type x y z

velocity all create 1.0e-6 12345

fix npt_all all npt temp 1e-6 1e-6 1000.0 iso 0.0 0.0 1000.0

run 10000

write_dump all custom quartz_3.lammpstrj id type x y z

