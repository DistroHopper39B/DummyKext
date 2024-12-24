# Script license: The Unlicense

#!/bin/bash
set -e

if [[ $(uname) != "Darwin" ]]; then
	echo "You can only easily build this under macOS. It's literally one byte of assembly, why are you even running this script?"
	exit 1
fi

if [[ $1 == "clean" ]]; then
	echo "Cleaning up..."
	rm -r Dummy.kext/ DummyKext
	exit 0
fi

echo "Assembling..."
cc -static -nostdlib --target=i386-apple-darwin8 -o DummyKext DummyKext.S

echo "Copying files..."
mkdir -p Dummy.kext/Contents/MacOS
cp DummyKext Dummy.kext/Contents/MacOS
cp Info.plist Dummy.kext/Contents

echo "All done! Dummy.kext can now be placed in /System/Library/Extensions on an Apple TV boot disk. Happy hacking!"