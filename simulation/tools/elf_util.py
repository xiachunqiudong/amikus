from elftools.elf.elffile import ELFFile
import sys

elf_path = sys.argv[1]
lineByteNum = int(sys.argv[2]) / 8

hex_path = elf_path.replace(".elf", ".hex") 

f = open(elf_path, "rb")
elf = ELFFile(f)

text_data = b""

for section in elf.iter_sections():
    if section.name == ".text":
        text_data = section.data()
        break
f.close()

hex_result = ""
byte_cnt = 0

line_result = ""
for byte in text_data:
    byte_cnt += 1
    line_result = f"{byte:02x}" + line_result
    if byte_cnt == lineByteNum:
      hex_result += line_result + "\n"
      line_result = ""
      byte_cnt = 0

with open(hex_path, "w") as hex_file:
    hex_file.write(hex_result)