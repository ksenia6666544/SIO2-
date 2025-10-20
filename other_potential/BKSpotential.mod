# Параметры решетки кварца
units metal
boundary p p p
atom_style charge  

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

set type 1 charge 4   # Заряд для кремния
set type 2 charge -2  # Заряд для кислорода

pair_style born/coul/long 10.0
pair_coeff 1 1 0.046 0.046 1.4408 25.151 0.0 10.0                    # Si-Si
pair_coeff 1 2 0.16 0.1560 2.5419 46.226 0.0 10.0   # Si-O  
pair_coeff 2 2 0.27 0.2630 3.6430 84.960 0.0 10.0   # O-O

kspace_style pppm 1.04e-4

dump min_all all custom 10 quartz_minimization.lammpstrj id type x y z fx fy fz
dump_modify min_all sort id

# Минимизация энергии
fix l all nve 
minimize 1.0e-10 1.0e-10 10000 10000
write_dump all custom quartz.lammp id type x y z

thermo_style custom step pe etotal press vol
thermo 10
run 50