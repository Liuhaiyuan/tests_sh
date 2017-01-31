#!/bin/bash
CDROM=/dev/cdrom
MOUNNT_DIR=/mnt/
[ -f $CDROM ] && mkdir $MOUNNT_DIR/rhel6 && mount $CDROM $MOUNNT_DIR && echo "mount success!" || echo "cdrom is not insert"
