To find the location of font files for figlet:
 > '$ figlet -I3'

Bug fixing: Font would not set correctly
 > PROBLEM: There is a bug with figlet fonts. it does not allow to set the commanded font "standard.ftf"
 > SOLUTION: It was discovered that the only font it accepted was "ascii9.tlf"
             To solve this problem, a copy of "standard.." was renamed to "ascii9.." and placed on config files for termux

