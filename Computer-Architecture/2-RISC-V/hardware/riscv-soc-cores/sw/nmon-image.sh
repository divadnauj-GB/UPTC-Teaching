if [ $# != 2 ]; then
	echo "Usage:"
	echo "  nmon-image <input-binary-file> <output-expect-file> <start-address>"

	exit 1
fi

hexdump -v -e '/4 "%08x\n"' $1 | perl -e '$a = 0x40000000; while (<>) { chop; printf("expect \"nmon> \"\n"); printf("send \"w%08x$_\"\n", $a); $a = $a + 4; }' > $2