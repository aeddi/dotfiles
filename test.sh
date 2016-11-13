#! /bin/bash

test() {
	{ {
		ls
		return 42;
	} 2>&1; } | (sed 's/^/   /' ; printf "TESt"); return ${PIPESTATUS[0]}
}
test
echo $?
