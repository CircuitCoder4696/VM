dub build --config='vmdk' --force --target=Windows
./vmdk -c ./test-assembler/myApp.hlAsm -args a b c -o ./myApp -args d e f
