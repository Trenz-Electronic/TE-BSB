= TE BSB =
This folder contains Base System Builder Wizard files for Xilinx EDK.

== Install ==
The board files has to be coplied into EDK installation location.
* Xilinx\13.2\ISE_DS\EDK\board

Also for the pcores, they have to appear under:

* Xilinx\13.2\ISE_DS\EDK\data\wizards\ipxact

== Notes ==
* Beware, xps_spi on ISE 13.x obtained inverted template map naming for 
miso/mosi pinout from now on, miso interpreted as output pin and mosi as input.
* slave_select signal become as chip_select.
Corresponding corrections are applied inside xps_spi_v2_02_b 
(this one will correctly map new template pins with ISE 12.x)