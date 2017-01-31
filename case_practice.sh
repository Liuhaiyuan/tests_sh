case $1 in
fedora)
	echo redhat;;
redhat)
	echo fedora;;
*)
	echo "Usage $0 [redhat|fedora]";;
esac
