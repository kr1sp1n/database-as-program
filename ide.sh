#!/bin/sh
# the next line restarts using wish \
exec wish "$0" ${1+"$@"}

package require Tk

source "packages/db_app.tcl"

set tcl_procedures [::db_app::all_procedures]

tk appname ide

set selected_procedure_id ""
set selected_procedure {}

set screen_width [winfo screenwidth .]
set screen_height [winfo screenheight .]
set width [expr {$screen_width/3}]
set height $screen_height

wm title . "Sidebar"
wm geometry . "=${width}x${screen_height}+0+0"

set tree .tree
ttk::treeview $tree
pack $tree -side top -expand 1 -fill both

$tree heading \#0 -text "Procedures"

set procedure_names {}
foreach procedure $tcl_procedures {
  lassign $procedure id name
  set name_index [lsearch $procedure_names $name]
  # if not in list:
  if [expr { $name_index == -1 }] {
    $tree insert {} end -id $id -text $name
    lappend procedure_names $name
  }
}

set w .editorView
toplevel $w
wm title $w "This is $w"
# Put a GUI in it
set textEditor [text $w.textEditor \
  -background black \
  -foreground white
]
pack $textEditor -expand 1 -fill both

proc saveProcedure {} {
  global selected_procedure_id
  global selected_procedure
  global textEditor
  lassign $selected_procedure id name arguments old_body
  set dump [$textEditor dump -text "1.0" end]
  set body ""
  for {set i 0} {$i<[llength $dump]} {incr i} {
    # format of dump: key value index ...
    set mod3 [expr { $i % 3 }]
    if {!$mod3} {
      set key [lindex $dump $i]
      if {[string equal $key "text"]} {
        set value [lindex $dump [expr {$i + 1}]]
        if {[expr {[string length $value] > 0}]} {
          set body [string cat $body $value]
        }
      }
    }
  }
  set old_body_sha3 [::db_app::sha3 $old_body]
  set new_body_sha3 [::db_app::sha3 $body]
  set is_equal [expr { $old_body_sha3 == $new_body_sha3 }]
  if {!$is_equal} {
    ::db_app::update_procedure $selected_procedure_id $name $arguments $body
  }
}

set saveButton [button $w.save -text Save -command saveProcedure]
pack $saveButton

bind $w <Control-s> {
  saveProcedure
}

wm withdraw $w
update
set x [expr {($screen_width-[winfo width $w])/2}]
set y [expr {($screen_height-[winfo height $w])/2}]
set editor_width [expr {$width * 2}]
wm geometry  $w "=${editor_width}x${height}+${width}+0"
wm transient $w .
wm title     $w "Dialog demo"
wm deiconify $w

bind $tree <<TreeviewSelect>> {
  global selected_procedure_id
  global selected_procedure
  set procedure_id [$tree focus]
  set selected_procedure_id $procedure_id
  set selected_procedure [::db_app::procedure $procedure_id]
  lassign $selected_procedure id name arguments body
  $textEditor replace "1.0" end $body
}