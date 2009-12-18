@ECHO OFF
echo -------------------------------------
echo -          compiling                -
echo -------------------------------------
echo *** boot.jos
nasm -f bin -i . -o boot.jos boot.asm
echo *** jos16.jos
nasm -f bin -i . -o jos16.jos __jos162.asm
echo *** jos32.jos
nasm -f bin -i . -o jos32.jos __jos32.asm
echo -------------------------------------
echo -        making bootdisk            -
echo -------------------------------------
echo *** writing boot.jos
partcopy boot.jos 0 200 -f0
echo *** writing jos16.jos
partcopy jos16.jos 0 200 -f0 200
echo *** writing jos32.jos
partcopy jos32.jos 0 200 -f0 400

