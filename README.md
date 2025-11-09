**Mesa 25.1.0 need to update Meson version**

Error: [ERROR: Meson version is 0.53.2 but project requires >= 1.3.0]
How to update:
1. Install meson with pip

  $ python3.10 -m pip install --user --upgrade meson
  
  #Check: ~/.local/bin/meson --version  

2. Add new meson into PATH
   
  $ export PATH="$HOME/.local/bin:$PATH"

  #Check: meson --version


- When running gen-ninja.sh script file
  
  ./gen-ninja.sh <SRC_PATH> <BUILD_PATH> <MESA_CLC_PATH> <NDK_PATH>
  
  (<MESA_CLC_PATH> is defined /../../bin) to avoid some issue
