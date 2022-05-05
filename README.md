# database as program

Inspired by https://www.tcl.tk/community/tcl2004/Papers/D.RichardHipp/drh.html

## Execute script

```bash
./init.sh
```

## Show schema of db

```bash
sqlite3 --ascii --batch app.db ".schema"
```

## Show procedures saved in db

```bash
sqlite3 --box --batch app.db "SELECT * FROM procedures;"
```
