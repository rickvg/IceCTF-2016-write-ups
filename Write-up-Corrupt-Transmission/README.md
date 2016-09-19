# Write-up Corrupt Transmission IceCTF 2016

In this challenge you receive a corrupt PNG-file: corrupt.png
When opening this file in an image viewer, you receive an error showing the image is corrupt.

The file was then opened in 010 Editor. According to the PNG-file structure (http://www.libpng.org/pub/png/spec/1.2/PNG-Structure.html), the PNG-file magic value is 89 50 4e 47 0d 0a 1a 0a.
However, that's not the case in this image. The PNG-file contains the IHDR chunk and IDAT chunks, so it should be a PNG-file.
By replacing the hexadecimal value of the first 16 bytes of the PNG-file with 89 50 4e 47 0d 0a 1a 0a, the image was not corrupt anymore.

The flag was inside the image:
> IceCTF{t1s_but_4_5cr4tch}
