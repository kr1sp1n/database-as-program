#!/usr/bin/wish
package require Tk 8.6-10 ;# needed for lmap
foreach row {0 1 2 3 4 5 6} {
    grid {*}[lmap {column} {"" A B C D E F} {
        set cell $column$row
        if {$column eq "" || $row == 0} {
            ::ttk::label .label$cell -text [expr {$row ? $row : $column}]
        } else {
            set ::formula($cell) [set ::$cell ""]
            trace add variable ::$cell read recalc
            ::ttk::entry .cell$cell -textvar ::$cell -width 10 -validate focus \
                    -validatecommand [list ::reveal-formula $cell %V %s]
        }
    }]
}
proc recalc {cell args} {
    catch {set ::$cell [uplevel #0 [list \
           expr [regsub -all {([A-F][1-6])} $::formula($cell) {$\1}]]]}
}
proc reveal-formula {cell event value} {
    if {$event eq "focusin"} {
        if {$::formula($cell) ne ""} { set ::$cell =$::formula($cell) }
        .cell$cell selection range 0 end
        .cell$cell icursor end
    } else { ;# focusout
        if {![regexp {^=(.*)} $value -> ::formula($cell)]} { set ::formula($cell) "" }
        foreach otherCell [array names ::formula] { recalc $otherCell }
    }
    return 1
}
# --- That's all, folks! ---