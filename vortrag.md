# Tcl/Tk

## Database As Program - Teil 1

https://www.tcl.tk/community/tcl2004/Papers/D.RichardHipp/drh.html

```bash
./init.sh
```

### Idee
- Quelltext einer Applikation in SQLite DB
- dynamisches Laden von Prozeduren zur Laufzeit
- verschiedene Versionen einer "Datei" in DB
- Editor als GUI

---

## Tcl

- tool command language (tickle)
- 1988 von John Ousterhout
- keine reservierten Wörter (z.B. 'for', 'if' 'while')
- plattformunabhängig (Linux, Mac OS, Windows etc.)
- selbstmodifizierender Code zur Laufzeit ('Metaprogramming')
- verschiedene Programmierparadigmen möglich (z.B. funktional, objekt-orientiert)
- Mehr Infos: https://de.wikipedia.org/wiki/Tcl
- Code-Beispiele: https://learnxinyminutes.com/docs/tcl/

### Interpreter

- tclsh: https://tcl.tk/man/tcl/UserCmd/tclsh.htm
- wish (GUI): https://www.tcl.tk/man/tcl/UserCmd/wish.html
- tclkit: https://www.equi4.com/tclkit/docs.html
  - KitCreator: https://kitcreator.rkeene.org/
    -  Online Build System: http://kitcreator.rkeene.org/kitcreator

### Kommandos und Variablen

Absolut konsequenter Einsatz einer einheitlichen Syntax:

```
Kommandowort param-1 param-2 ... param-N
```

Beispiel:
```
set title "Hello from Tcl."
puts $title
```

### Evaluierung von Skripten

Beispiel:
```
set i 0 
puts $i
puts [incr i]

set count [
   incr i
   incr i
   incr i
]
puts $count
```

### Prozeduren und Blöcke

Beispiel:
```
proc * {a b} {
  expr $a * $b
}

puts [* 2 3]
```

### Listen

Beispiel:
```
set x [list a b "c d e" 1 2 3]
puts $x
```

### Pakete und Namespaces

Beispiel 'Pakete laden':
```
package require Tk
package require http
```

Beispiel 'namespace':
```
namespace eval ::LOL {
  namespace export test
}

proc ::LOL::test {} {
  puts "LOL"
}

package provide LOL 1.0.0
```

Beispiel 'Pakete in Ordnern finden und laden':
```
proc load_package {name version} {
  # append current dir to find packages
  lappend auto_path [pwd]
  package ifneeded $name $version [list source [file join [pwd] "packages" "$name.tcl"]]
}

package unknown load_package
package require LOL 1.0.0
```

---

## Tk (Toolkit)

https://de.wikipedia.org/wiki/Tk_(Toolkit)

- plattformunabhängige grafische Benutzeroberflächen
- Schnittstellen zur Nutzung in anderen Programmiersprachen (z.B. Perl, Python, Ruby)

Beispiel:
```
package require Tk
pack [button .b -text "Goodbye World" -command exit]
```

---

## Sqlite und Tcl

http://www.sqlite.org/tclsqlite.html

Beispiel:
```
sqlite3 db app.db -create true
set result [db eval "SELECT * FROM procedures"]
```

### SQLite-Erweiterungen laden

Beispiel:
```
db enable_load_extension true
db eval { SELECT load_extension("ulid"); }
```

---

## Database As Program - Teil 2

### DB Schema

```bash
sqlite3 app.db .schema
```

### Prozedur überschreiben

```sql
INSERT INTO procedures (name,arguments,body) VALUES ('::hello','name','puts "Hi $name."');
```

### Editor in tk

```bash
./ide.sh
```

---

# Fragen?