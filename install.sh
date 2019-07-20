#!/data/data/com.termux/files/usr/bin/bash

javac=/data/data/com.termux/files/usr/bin/javac
java=/data/data/com.termux/files/usr/bin/java

cat > $javac <<-'EOF'
	if [ -z "$1" ] || ! [ -f "$1" ]; then
	  echo "$1 File not Found" >&2
	  exit
	elif [ -z "$(command -v ecj)" ] || [ -z "$(command -v dx)" ]; then
	  echo "ecj/dx not Found" >&2
	  exit
	fi
	dir="$(dirname "$(realpath "$1")")"
	name="$(basename "$1" .java)"
	cd "$dir"
	ecj "${name}.java" || {
	  echo "Unable to compile $1"; exit
	}
	dx --dex --output="${name}.dex" "${name}.class" || {
	  echo "Unable to dex classes"; exit
	}
	rm -f "${name}.class"
EOF

cat > $java <<-'EOF'
	if [ -z "$1" ] || ! [ -f "${1}.dex" ]; then
	  echo "$1 File not Found" >&2
	  exit
	fi
	dir="$(dirname "$(realpath "${1}.dex")")"
	name="$(basename "$1")"
	dalvikvm -cp "${dir}/${name}.dex" "${name}" || {
	  echo "Unable to run java package"; exit
	}
EOF

chmod 755 $javac $java
