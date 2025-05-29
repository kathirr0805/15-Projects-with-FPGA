# FPGA Projects Collection

## Overview
This repository contains a collection of 15 FPGA projects showcasing a variety of applications for Field-Programmable Gate Arrays (FPGAs). These projects are designed to explore digital design, covering topics from basic LED control to advanced signal generation. The projects are primarily implemented using Verilog or VHDL. All project files, including source code, simulation files, and documentation, are hosted on Google Drive for easy access and collaboration.

## Project List
Below is the list of 15 FPGA projects included in this collection:

1. ** LED Blinking**: A simple project to blink an LED on an FPGA board at a fixed frequency.
2. **Switch-based LED Control**: Controls LEDs based on switch inputs, demonstrating basic input/output interfacing.
3. **3,4-bit Binary Counter**: Implements 3-bit and 4-bit binary counters with output displayed on LEDs or a 7-segment display.
4. **7-Segment Display Counter**: A counter that displays its value on a 7-segment display, with configurable counting speed.
5. **Pushbutton Debounce Circuit**: Debounces a pushbutton input to prevent multiple triggers from a single press.
6. **FSM Traffic Light Controller**: A finite state machine (FSM) to control a traffic light system with red, yellow, and green LEDs.
7. **Frequency (Clock Divider)**: Divides the FPGA clock to generate lower-frequency signals for various applications.
8. **8-LED Chaser**: Creates a chasing effect across 8 LEDs, with adjustable speed and direction.
9. **Stop Watch with 7-Segment Display**: A stopwatch that displays time on a 7-segment display, with start/stop functionality.
10. **Simple Calculator**: Implements basic arithmetic operations (addition, subtraction) on an FPGA with switch inputs and display output.
11. **Random Number Generator using LFSR**: Generates pseudo-random numbers using a Linear Feedback Shift Register (LFSR).
12. **Reaction Timer Game**: Measures reaction time by timing a user’s response to an LED trigger, displaying results on a 7-segment display.
13. **SRAM Read/Write Operations**: Demonstrates reading and writing to SRAM memory interfaced with an FPGA.
14. **SDRAM Controller Implementation**: Implements a controller for SDRAM, enabling high-speed memory access for FPGA applications.
15. **VGA Signal Generation**: Generates VGA signals to display simple graphics or text on a monitor.

## Features
- **Wide Range of Applications**: Projects cover digital design fundamentals, memory interfacing, and signal generation.
- **Verilog/VHDL Implementation**: Most projects are coded in Verilog or VHDL, with testbenches for simulation.
- **Simulation Ready**: Includes testbenches for verifying designs using tools like ModelSim or Vivado Simulator.
- **Modular Design**: Projects are standalone, allowing easy modification or integration into larger systems.

## Access Project Files
All project files, including source code, Vivado project files, simulation scripts, and documentation, are available on Google Drive:

[**Access FPGA Projects on Google Drive**]([https://drive.google.com/your-folder-link-here](https://drive.google.com/drive/folders/12aOOJCHkLiPda5yPwKt0yN_HOv58rfwm?usp=drive_link))

**Instructions to Access**:
1. Click the link above to open the Google Drive folder.
2. Ensure you are logged into a Google account with access (contact the owner if access is restricted).
3. Download or view files directly in the browser.
4. To contribute, request edit access from the folder owner or drag and drop files into the shared folder if permissions allow.

**Note**: The Google Drive folder is set to "Anyone with the link" for view access. For sensitive projects, adjust permissions to "Restricted" or specific email access for security.

## Requirements
### Hardware
- FPGA development board (e.g., Basys 3, Nexys 4, or DE10-Nano).
- LEDs, switches, 7-segment displays, and pushbuttons (for basic projects).
- SRAM/SDRAM modules (for memory-related projects).
- VGA-compatible monitor (for VGA Signal Generation project).
- Computer with USB ports for programming and simulation.

### Software
- **FPGA Development**:
  - Xilinx Vivado or equivalent FPGA design suite.
  - ModelSim or Vivado Simulator for testbench verification.
  - Verilog/VHDL compilers (e.g., Yosys for open-source synthesis).
- **General**:
  - Google Drive access for downloading project files.
  - Proteus or similar for simulating embedded systems (optional).

## Installation
1. **Download Projects**:
   - Access the Google Drive link and download the desired project folders.
   - Ensure sufficient storage (some projects include large Vivado files).
2. **FPGA Projects**:
   - Open project files in Vivado or your preferred FPGA tool.
   - Synthesize and implement designs following provided documentation.
   - Upload bitstreams to your FPGA board.
3. **Simulation**:
   - Use ModelSim or Vivado Simulator for Verilog/VHDL testbenches.

## Usage
1. **FPGA Projects**:
   - Open each project in Vivado, review the documentation, and run simulations.
   - Program the FPGA board with the generated bitstream.
   - Test functionality using external peripherals (e.g., LEDs, displays, monitors).
2. **Sharing and Collaboration**:
   - Use the Google Drive link to share projects with collaborators.
   - Update files in the shared folder to maintain the same link for seamless updates.

## Troubleshooting
- **Google Drive Access Issues**: Verify your Google account has permission or request access from the folder owner.
- **FPGA Synthesis Errors**: Check Vivado logs for syntax errors or missing IP cores. Ensure all dependencies are installed.
- **Simulation Issues**: Ensure testbenches are correctly referenced in the project settings.

## Contributing
To contribute to this project collection:
1. Request edit access to the Google Drive folder.
2. Upload new project files or updated versions to the appropriate subfolder.
3. Document changes in the project’s README or changelog file.
4. Ensure compatibility with Vivado for consistency.

## License
This project collection is licensed under the MIT License.

## Acknowledgments
- Xilinx Vivado for FPGA development and synthesis.
- The FPGA community for inspiration and resources.
