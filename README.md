# Formide-Touch

Formide-Touch is a library you can import to create a Qt UI Application, and it provides all necessary functions and timers to make it work with a 3D printer compatible with Formide.

At the same time, it is an API wrapper for Formide Client, including a wide list of functions, classes and event handlers to make the development of your application really easy.


## Features
* Emission of events when connecting / disconnecting printers, printer started, finished, paused, and more.
* Control one or many printers at the same time.
* Send gcode commands.
* Print Gcode files.
* Pause / Resume / Stop prints.
* Manage Cloud Queue.
* Register device to Formide Account.
* Upload and store files, or download them from Formide Cloud.
* Check printer status (temperatures, progress, coordinates, current layer, etc).


# Documentation
Please find all the documentation in this project's [wiki](https://github.com/PRINTR3D/formide-touch/wiki).


# Installation
Installation of this library can be done with `npm`:
```
npm install --save formide-touch
```


# Build
The build process depends on the project where the library is included.
Build instructions for a normal Qt Application can be found [here](https://github.com/PRINTR3D/formide-shared-ui/wiki/Build-and-Run).



# Contributing
You can contribute to `formide-touch` by closing issues (via fork -> pull request to development), adding features or just using it and report bugs!
Please check the issue list of this repo before adding new ones to see if we're already aware of the issue that you're having.



# Licence
Please check LICENSE.md for licensing information.
