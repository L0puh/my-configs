import subprocess
a = subprocess.check_output("xclip -out -sel -f", shell = True)
print(a)
