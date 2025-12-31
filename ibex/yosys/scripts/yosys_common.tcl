set variables {
    sv_flist    { SV_FLIST    "/foss/designs/ibex/build/ibex_out/lint-verilator/sources.flist" }
    top_design  { TOP_DESIGN  "ibex_wrap"     }
    period_ps   { PERIOD_PS   100000          }
    out_dir     { OUT         out             }
    tmp_dir     { TMP         tmp             }
    rep_dir     { REPORTS     reports         }
}

# check if an env-var exists and is non-empty
proc envVarValid {var_name} {
    if { [info exists ::env($var_name)]} {
        if {$::env($var_name) != "0" && $::env($var_name) ne ""} {
            return 1
        }
    }
    return 0
}

# If the ENVVAR is valid use it, otherwise use fallback
foreach var [dict keys $variables] {  
    set values [dict get $variables $var]
    set env_var [lindex $values 0]
    set fallback [lindex $values 1]
    if {[envVarValid $env_var]} {
        puts "using: $var='$::env($env_var)'"
        set $var $::env($env_var)
    } else {
        puts "using fallback: $var='$fallback'"
        set $var $fallback
    }
}

# Create necessary directories
file mkdir $out_dir
file mkdir $tmp_dir
file mkdir $rep_dir
puts "Created directories: $out_dir, $tmp_dir, $rep_dir"

# process ABC script and write to temporary directory
proc processAbcScript {abc_script} {
    global tmp_dir
    puts "reading abc script: $abc_script"
    puts "tmp_dir: $tmp_dir"
    
    set src_dir [file join [file dirname [info script]] ../src]
    set abc_out_path [file join $tmp_dir [file tail $abc_script]]
    set raw [read -nonewline [open $abc_script r]]
    set abc_script_recaig [string map -nocase [list "{REC_AIG}" [subst "$src_dir/lazy_man_synth_library.aig"]] $raw]
    set abc_out [open $abc_out_path w]
    puts -nonewline $abc_out $abc_script_recaig
    flush $abc_out
    close $abc_out
    return $abc_out_path
}
