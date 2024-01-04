if [ ! -d "$build" ]; then
   mkdir build 
   cd build
   cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
fi
cd build
make 
cd .. 
