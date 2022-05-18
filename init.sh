#!/bin/sh
# the next line restarts using tclsh \
exec tclsh "$0" ${1+"$@"}

source "packages/db_app.tcl"

# Save the original one so we can chain to it:
rename unknown _original_unknown

# Provide own implementation:
proc unknown args {
  set name [lindex $args 0]
  set arguments [lindex $args 1]
  #puts $args
  if {![::db_app::has_procedure $name]} {
    ::db_app::insert_example_procedures
    # puts stderr "No ::main procedure in db."
    # exit 1
  }
  ::db_app::load_procedure $name
  eval $name $arguments
}

# proc load_package {name version} {
#   # append current dir to find packages
#   lappend auto_path [pwd]
#   package ifneeded $name $version [list source [file join [pwd] "packages" "$name.tcl"]]
# }

# package unknown load_package

# package require LOL 1.0.0
# package require db_app 1.0.0
#::LOL::test

proc init {name} {
  # defined in file:
  ::db_app::create_procedures_table
  # defined in sqlite db:
  ::main $name
}

set name [expr {[llength $argv] == 0 ? "World" : [lindex $argv 0]}]

init $name