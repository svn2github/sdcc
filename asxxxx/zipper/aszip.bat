del as*.zip
del as*.exe
cd ..
cd ..
.\asxxxx\zipper\pkzip.exe -rP .\asxxxx\zipper\asx.zip asxxxx\*.*
.\asxxxx\zipper\pkzip.exe -d  .\asxxxx\zipper\asx.zip asxxxx\zipper\pkzip.exe
.\asxxxx\zipper\pkzip.exe -d  .\asxxxx\zipper\asx.zip asxxxx\zipper\zip2exe.exe
.\asxxxx\zipper\pkzip.exe -a  .\asxxxx\zipper\asx.zip asxxxx\readme.txt
cd asxxxx
cd zipper
zip2exe.exe asx.zip

