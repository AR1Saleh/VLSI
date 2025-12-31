yosys -import

# This flows assumes it is beign executed in the yosys/ directory
# but just to be sure, we go there
if {[info script] ne ""} {
    cd "[file dirname [info script]]/../"
}

# Configuration variables are in yosys_commono
# get environment variables
source scripts/yosys_common.tcl

# ABC logic optimization script
set abc_script [processAbcScript scripts/abc-opt.script]

# read liberty files and prepare some variables
source scripts/init_tech.tcl

plugin -i slang.so

read_slang --top ibex_wrap \
           -I /foss/designs/ibex/build/ibex_out/src/lowrisc_prim_assert_0.1/rtl \
           -I /foss/designs/ibex/build/ibex_out/src/lowrisc_prim_util_memload_0/rtl \
           -I /foss/designs/ibex/build/ibex_out/src/lowrisc_dv_dv_fcov_macros_0 \
           -I /foss/designs/ibex/build/ibex_out/src/lowrisc_prim_util_get_scramble_params_0/rtl \
           -DINC_ASSERT \
           -F /foss/designs/ibex/build/ibex_out/lint-verilator/sources.flist \
           /foss/designs/ibex/yosys/src/ibex_wrap.sv \
           --allow-use-before-declare \
           --ignore-unknown-modules \
           --ignore-assertions


# map dont_touch attribute commonly applied to output-nets of async regs to keep
yosys attrmap -rename dont_touch keep
# copy the keep attribute to their driving cells (retain on net for debugging)
yosys attrmvcp -copy -attr keep

# -----------------------------------------------------------------------------
# this section heavily borrows from the yosys synth command:
# synth - check
yosys hierarchy -top $top_design
yosys check
#exit
yosys proc
yosys tee -q -o "${rep_dir}/${top_design}_elaborated.rpt" stat
yosys write_verilog -norename -noexpr -attr2comment ${tmp_dir}/${top_design}_yosys_elaborated.v

# synth - coarse:
# similar to yosys synth -run coarse -noalumacc
yosys opt_expr
yosys opt -noff
yosys fsm
yosys tee -q -o "${rep_dir}/${top_design}_initial_opt.rpt" stat
yosys wreduce 
yosys peepopt
yosys opt_clean
yosys opt -full
yosys booth
yosys share
yosys opt
yosys memory -nomap
yosys tee -q -o "${rep_dir}/${top_design}_memories.rpt" stat
yosys write_verilog -norename -noexpr -attr2comment ${tmp_dir}/${top_design}_yosys_memories.v
yosys memory_map
yosys opt -fast

yosys opt_dff -sat -nodffe -nosdff
yosys share
yosys opt -full
yosys clean -purge

yosys write_verilog -norename ${tmp_dir}/${top_design}_yosys_abstract.v
yosys tee -q -o "${rep_dir}/${top_design}_abstract.rpt" stat -tech cmos

yosys techmap
yosys opt -fast
yosys clean -purge


# -----------------------------------------------------------------------------
yosys tee -q -o "${rep_dir}/${top_design}_generic.rpt" stat -tech cmos
yosys tee -q -o "${rep_dir}/${top_design}_generic.json" stat -json -tech cmos

# flatten all hierarchy except marked modules
yosys flatten

yosys clean -purge


# -----------------------------------------------------------------------------
# Preserve flip-flop names as far as possible
# split internal nets
yosys splitnets -format __v
# rename DFFs from the driven signal
yosys rename -wire -suffix _reg t:*DFF*
yosys select -write ${rep_dir}/${top_design}_registers.rpt t:*DFF*
# rename all other cells
yosys autoname t:*DFF* %n
yosys clean -purge

# print paths to important instances (hierarchy and naming is final here)
yosys select -write ${rep_dir}/${top_design}_registers.rpt t:*DFF*
yosys tee -q -o ${rep_dir}/${top_design}_instances.rpt  select -list "t:RM_IHPSG13_*"
yosys tee -q -a ${rep_dir}/${top_design}_instances.rpt  select -list "t:tc_clk*$*"


# -----------------------------------------------------------------------------
# mapping to technology

# first map flip-flops
yosys dfflibmap {*}$tech_cells_args

# then perform bit-level optimization and mapping on all combinational clouds in ABC
set period_ps 10000
# pre-process abc file (written to tmp directory)
set abc_comb_script   [processAbcScript scripts/abc-opt.script]
# call ABC
yosys abc {*}$tech_cells_args -D $period_ps -script $abc_comb_script -constr src/abc.constr -showtmp

yosys clean -purge


# -----------------------------------------------------------------------------
# prep for openROAD
yosys write_verilog -norename -noexpr -attr2comment ${out_dir}/${top_design}_yosys_debug.v

yosys splitnets -ports -format __v
yosys setundef -zero
yosys clean -purge
# map constants to tie cells
yosys hilomap -singleton -hicell {*}$tech_cell_tiehi -locell {*}$tech_cell_tielo

# final reports
yosys tee -q -o "${rep_dir}/${top_design}_synth.rpt" check
yosys tee -q -o "${rep_dir}/${top_design}_area.rpt" stat -top $top_design {*}$liberty_args
yosys tee -q -o "${rep_dir}/${top_design}_area_logic.rpt" stat -top $top_design {*}$tech_cells_args

# final netlist
yosys write_verilog -noattr -noexpr -nohex -nodec ${out_dir}/${top_design}_yosys.v

