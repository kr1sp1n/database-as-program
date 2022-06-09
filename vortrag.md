# tcl/tk

## Database As Program - Teil 1

```bash
./init.sh
```

https://www.tcl.tk/community/tcl2004/Papers/D.RichardHipp/drh.html

### Idee
- Quelltext einer Applikation in SQLite DB
- dynamisches Laden von Prozeduren zur Laufzeit
- verschiedene Versionen einer "Datei" in DB
- Editor als GUI

---

## tcl

- tool command language (tickle)
- 1988 von John Ousterhout
- keine reservierten Wörter (z.B. 'for', 'if' 'while')
- plattformunabhängig (Linux, Mac OS, Windows etc.)
- selbstmodifizierender Code zur Laufzeit ('Metaprogramming')
- verschiedene Programmierparadigmen möglich (z.B. funktional, objekt-orientiert)

### Kommandos und Variablen

Absolut konsequenter Einsatz einer einheitlichen Syntax:

```
Kommandowort param-1 param-2 ... param-N
```

Beispiel:
```
set title "Hello from tcl."
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

---

## tk

- plattformunabhängige grafische Benutzeroberflächen
- Schnittstellen zur Nutzung in andern Programmiersprachen (z.B. Perl, Python, Ruby)

Beispiel:
```
package require Tk
pack [button .b -text "Goodbye World" -command exit]
```

---

## Sqlite und tcl

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