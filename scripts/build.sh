if [ ! -d "$build" ]; then
   mkdir build 
   cd build
else 
   cd build
fi
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make 
cd .. 
