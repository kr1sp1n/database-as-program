#!/bin/sh
# the next line restarts using wish \
exec wish "$0" ${1+"$@"}

set screen_width [winfo screenwidth .]
set screen_height [winfo screenheight .]

wm title . "Sidebar"

set tree .tree
ttk::treeview $tree
pack $tree -side top -expand 1 -fill both

$tree heading \#0 -text "Namespaces"

$tree insert {} end -id "Item 1" -text "Item 1"
$tree insert {} end -id "Item 2" -text "Item 2"
$tree insert {} end -id "Item 3" -text "Item 3"

$tree insert "Item 1" end -id "Item 1-1" -text "Item 1-1"
$tree insert "Item 1" end -id "Item 1-2" -text "Item 1-2"
$tree insert "Item 1" end -id "Item 1-3" -text "Item 1-3"

$tree insert "Item 2" end -id "Item 2-1" -text "Item 2-1"
$tree insert "Item 2" end -id "Item 2-2" -text "Item 2-2"
$tree insert "Item 2" end -id "Item 2-3" -text "Item 2-3"

set w .editorView
toplevel $w
wm title $w "This is $w"
# Put a GUI in it
set textEditor [text $w.textEditor -background black -foreground white]
pack $textEditor
pack [label $w.xmpl -text "This is an example"]
pack [button $w.ok -text OK -command [list destroy $w]]

wm withdraw $w
update
set x [expr {($screen_width-[winfo width $w])/2}]
set y [expr {($screen_height-[winfo height $w])/2}]
set width [expr {$screen_width/3}]
set height $screen_height
wm geometry  $w "=${width}x${height}+${x}+${y}"
wm transient $w .
wm title     $w "Dialog demo"
wm deiconify $w