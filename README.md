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

## Insert procedure

```sqlite3
INSERT INTO procedures (name,arguments,body) VALUES ('::hello','name','puts "Hi $name."');
```

## Update procedure via editor

```sqlite
UPDATE procedures SET body=edit(body,'nano') WHERE id LIKE '01G2XRV8BVRY36Q3ETV67MY893';
```