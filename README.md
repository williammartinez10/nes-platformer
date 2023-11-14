# NES6502 Game Project - William A. Martínez Martínez


## Project Overview / Main Objective
This project aims to create a platformer game where a player can jump and move around a background, using NES6502 Assembly.

  
## Folder Structure
- Project
  - ```compiling-resources```
    - d1-compiling-script.txt
    - d2-compiling-script.txt
    - d3-compiling-script.txt
    - d4-compiling-script.txt
  - ```Deliverable1```
    - background.asm
    - background.chr
    - background.nes
    - background.o
    - canvas.asm
    - constants.inc
    - header.inc
    - reset.asm
    - reset.o
  - ```Deliverable2```
    - constants.inc
    - header.inc
    - player.asm
    - player.chr
    - player.nes
    - player.o
    - reset.asm
    - reset.o
  - ```Deliverable3```
    - animation.asm
    - animation.chr
    - animation.nes
    - animation.o
    - constants.inc
    - header.inc
    - reset.asm
    - reset.o
  - ```Deliverable4```
    - canvas.asm
    - constants.inc
    - header.inc
    - movement.asm
    - movement.chr
    - movement.nes
    - movement.o
    - reset.asm
    - reset.o
  - nes.cfg

  
## Deliverables / Steps for Achieving Main Objective
- **```Deliverable1:```** Folder with program displaying a background on screen containing 6 elements (small stars, big stars, moon, clouds, floating platform, and floor) and 11 different colors.
- **```Deliverable2:```** Folder with program displaying all character sprites designs on screen separately, facing both sides (right and left).
- **```Deliverable3:```** Folder with program showcasing the character in the same position (x,y) but constantly showing the walking/running animation.
- **```Deliverable4:```** Folder with program that allows the player to move through the background, with respect to the buttons pressed on the control. (**Note**: This is the intended goal. However, only the background and animated player are included in this deliverable.)

  
## Videos Showcasing Each Deliverable
- Videos related to each of the deliverables have been published on YouTube. You can use the following link to visit a playlist dedicated for this.
  - <a href="https://youtube.com/playlist?list=PLCaJpDWLRzoGp6fcWgpsY9xY7E-h9gVbY&si=enK-FdABqvhUVnQI">Project Playlist</a>
- Alternatively, here are the individual links to each of the deliverable videos:
  - <a href="https://youtu.be/yEXSIisJsQg">Deliverable 1</a>
  - <a href="https://youtu.be/1dX8V92HoLM">Deliverable 2</a>
  - <a href="https://youtu.be/GYdMxplBCbw">Deliverable 3</a>
  - <a href="https://youtu.be/HZ_5M0yP_dI">Deliverable 4</a>


## Deliverable Captures (In order: 1, 2, 3, 4)
<img width="512" alt="Screenshot 2023-11-12 at 3 09 09 PM" src="https://github.com/williammartinez10/CIIC4082-NES6502_Project/assets/77518982/1b537434-8fba-4cd5-87c6-9c002dca3efc">

<img width="512" alt="Screenshot 2023-11-12 at 3 12 24 PM" src="https://github.com/williammartinez10/CIIC4082-NES6502_Project/assets/77518982/caec9bca-cb91-44d9-8c0c-15c97243258b">

https://github.com/williammartinez10/CIIC4082-NES6502_Project/assets/77518982/3872b6b3-6fe8-43e5-bb08-424d0d4871b4

https://github.com/williammartinez10/CIIC4082-NES6502_Project/assets/77518982/97b86e01-4079-420d-9909-0c830d2300db


  
## How to Compile Each Deliverable
- Go to ```compiling-resources``` folder, choose the text file corresponding to the deliverable you are going to test out, copy and paste its contents in the terminal. (**Note**: You need to be inside the ```Project``` directory, in order to be able to use the .txt files inside compiling resources)

## Dependencies
- Assembler ```ca65``` and linker ```ld65``` - https://cc65.github.io/
- ```Nexxt``` gaphics tool - https://frankengraphics.itch.io/nexxt
- ```Mesen2``` emulator - https://www.mesen.ca/ (Alternative for Mac, ```Nintaco``` - https://nintaco.com/)
- Text Editor of your choice

## Contact Information
- Any comments or suggestions, email me at william.martinez10@upr.edu

