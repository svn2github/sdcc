# Simple script that takes a win32 release and tidies
# it up by converting it to a zip and fixing up some
# text files

echo "Tidying up $1";

rm -rf sdcc
tar xzf $1

find sdcc -name "*.txt" -exec unix2dos {} \;
mv sdcc/bin/sdcpp sdcc/bin/sdcpp.exe
zip -9r `basename $1 .tar.gz`.zip sdcc
