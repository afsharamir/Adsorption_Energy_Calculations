#!/bin/bash

DIR="/users/lspragu1/data/lspragu1/local/q-e-qe-6.3"

PSEUDO_DIR="./pseudo-gbrv-pbe/"
#EXCT_PW="$DIR/bin/pw.x"
#EXCT_PH="$DIR/bin/ph.x"
#EXCT_DIR="$DIR/bin"
EXCT_PW="/gpfs/runtime/opt/quantumespresso/6.6/bin/pw.x"
EXCT_PH="/gpfs/runtime/opt/quantumespresso/6.6/bin/ph.x"
EXCT_DIR="/gpfs/runtime/opt/quantumespresso/6.6/bin"
MPI_CMD="srun --mpi=pmix -n 16"

a="4.0"
c="30.0"
PREFIX="CuPd_rlx_1st_BBEF-vdW"
ECUTWFC=60
ECUTRHO=650
KPTSX=4
KPTSY=4
KPTSZ=1
KPTSXX=40
KPTSYY=40
KPTSZZ=1

OUTDIR="/users/aafshar4/scratch/"

#------------------------------RELAX------------------------
# self-consistent calculation
cat > $PREFIX.rlx.in <<EOF
 &control
    calculation = 'relax',
    prefix = '$PREFIX',
!    restart_mode='from_scratch',
    restart_mode='restart',
    pseudo_dir ='$PSEUDO_DIR',
    outdir ='$OUTDIR',
    wf_collect=.true.,
    tstress = .true.,
    tprnfor = .true.,
    max_seconds = 30000,
    etot_conv_thr = 1.0d-7,
    forc_conv_thr = 1.0d-6,
 /
 &system
    ibrav=0,
!    celldm(1)=7.55890453,
!    a = $a,
!    c = $c,
    nat=48,
    ntyp=2,
    ecutwfc = $ECUTWFC,
    ecutrho = $ECUTRHO,
!    occupations='fixed',
    occupations='smearing',
    smearing='mp',
    degauss=0.02,
    input_dft='PBE',
!    nspin=2,
!    tot_magnetization=1.0d-20,
!    startin g_magnetization(5)=1.0d-20,
!    lda_plus_u=.true.,
!    Hubbard_U(2)=0.0,
!    lspinorb= .true.,
!    noncolin= .true.,
 /
 &electrons
    diagonalization = 'david',
    mixing_mode = 'plain',
    mixing_beta = 0.3,
    conv_thr =  1.0d-10,
    electron_maxstep = 200,
 /
 &ions
    ion_dynamics = 'bfgs',
!    trust_radius_max=0.3,
!    trust_radius_min=1.0d-4,
 /
 &cell
    cell_dynamics = 'bfgs',
    press=0.0,
!    wmass=1.0d-5,
    cell_dofree = '2Dxy',
/
ATOMIC_SPECIES
    Cu  63.546  cu_pbe_v1.2.uspp.F.UPF
    Pd  106.42  pd_pbe_v1.4.uspp.F.UPF
ATOMIC_POSITIONS angstrom
Cu    0.0000000000    0.0000000000    0.5542499830
Cu    2.1121251090    2.1121266610    0.5542716120
Pd    0.0000000000    2.1121169440    1.9392228580
Pd    2.1121200970    0.0000000000    1.9392198410
Cu    0.0000000000    4.2242543590    0.5543113570
Cu    2.1121251090    6.3363836980    0.5542716120
Pd    0.0000000000    6.3363934150    1.9392228580
Pd    2.1121327900    4.2242543590    1.9392167660
Cu    4.2242762390    0.0000000000    0.5542986960
Cu    6.3363823590    2.1120987990    0.5542842430
Pd    4.2242511850    2.1121342620    1.9392187870
Pd    6.3363823590    0.0000000000    1.9392449830
Cu    4.2242568390    4.2242543590    0.5542741570
Cu    6.3363823590    6.3364115600    0.5542842430
Pd    4.2242511850    6.3363760970    1.9392187870
Pd    6.3363823590    4.2242543590    1.9391989610
Cu    8.4484868380    0.0000000000    0.5542986960
Cu   10.5606396090    2.1121266610    0.5542716120
Pd    8.4485118920    2.1121342620    1.9392187870
Pd   10.5606396090    0.0000000000    1.9392198410
Cu    8.4485062380    4.2242543590    0.5542741570
Cu   10.5606396090    6.3363836980    0.5542716120
Pd    8.4485118920    6.3363760970    1.9392187870
Pd   10.5606319280    4.2242543590    1.9392167660
Cu    0.0000000000    0.0000000000    3.5837865880
Cu    2.1121251090    2.1121266610    3.5838082170
Pd    0.0000000000    2.1121169440    4.9687594630
Pd    2.1121200970    0.0000000000    4.9687564460
Cu    0.0000000000    4.2242543590    3.5838479620
Cu    2.1121251090    6.3363836980    3.5838082170
Pd    0.0000000000    6.3363934150    4.9687594630
Pd    2.1121327900    4.2242543590    4.9687533710
Cu    4.2242762390    0.0000000000    3.5838353010
Cu    6.3363823590    2.1120987990    3.5838208480
Pd    4.2242511850    2.1121342620    4.9687553920
Pd    6.3363823590    0.0000000000    4.9687815880
Cu    4.2242568390    4.2242543590    3.5838107620
Cu    6.3363823590    6.3364115600    3.5838208480
Pd    4.2242511850    6.3363760970    4.9687553920
Pd    6.3363823590    4.2242543590    4.9687355660
Cu    8.4484868380    0.0000000000    3.5838353010
Cu   10.5606396090    2.1121266610    3.5838082170
Pd    8.4485118920    2.1121342620    4.9687553920
Pd   10.5606396090    0.0000000000    4.9687564460
Cu    8.4485062380    4.2242543590    3.5838107620
Cu   10.5606396090    6.3363836980    3.5838082170
Pd    8.4485118920    6.3363760970    4.9687553920
Pd   10.5606319280    4.2242543590    4.9687533710
CELL_PARAMETERS angstrom
   12.672767609    0.000000000   0.000000000
   0.0000000000    8.448521415   0.000000000
   0.0000000000    0.000000000   25.00000000
K_POINTS automatic
 $KPTSX $KPTSY $KPTSZ 0 0 0
EOF

$MPI_CMD $EXCT_PW < $PREFIX.rlx.in > $PREFIX.rlx.out

echo $i >>rlx_summary.out
grep ! $PREFIX.rlx.out >>rlx_summary.out
grep Fermi $PREFIX.rlx.out >>rlx_summary.out