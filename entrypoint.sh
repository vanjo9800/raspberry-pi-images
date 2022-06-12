#!/bin/bash
update-binfmts --install qemu-aarch64
/usr/sbin/update-binfmts --enable qemu-arm >/dev/null 2>&1
/usr/sbin/update-binfmts --enable qemu-aarch64 >/dev/null 2>&1

exit;

PACKER=/bin/packer

echo "Initialising packer"
$PACKER init ./plugin.pkr.hcl

echo "Running packer"
exec $PACKER build "${@}"
