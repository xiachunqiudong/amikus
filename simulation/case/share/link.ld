SECTIONS
{
  .text 0x80000000 : { *(.text) }
  .data : { *(.data) }
  .bss : { *(.bss) }
}