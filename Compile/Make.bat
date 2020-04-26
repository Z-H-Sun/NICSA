set PATH=C:\mingw64\bin;%PATH%
nuitka --mingw64 --show-progress --show-memory --standalone --enable-plugin=tk-inter --enable-plugin=multiprocessing --recurse-all --recurse-not-to=numpy,matplotlib --windows-icon="%~dp0\1.ico" ../nicsa
