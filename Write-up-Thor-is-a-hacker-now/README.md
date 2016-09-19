# Write-up Thor's a hacker now IceCTF 2016

In this challenge you receive a TXT-file: thor.txt. This file contains a hex-dump, so you might want to convert it to a usable file.
This can be done using the following command:

> xxd -r thor.txt > data

The command converts the hexdump to binary data, meaning file "data" is now a binary file.

Using the following command, we check what kind of file this is:
> file data

According to the magic header, shown by command "file", data is an LZIP-file which is an archive file format. To extract this file, I used: http://www.nongnu.org/lzip/lziprecover.html
I ran the following command to extract the file after installing LZIPRecover:

> wine plzip-1.5-rc2.win64.exe -d data

I put wine before the actual command, because plzip is a Windows Executable. Wine is open-source software for Linux to run Windows Executables. (https://www.winehq.org/)
The resulting file is a JPG-file, containing the flag on the image:
> IceCTF{h3XduMp1N9_l1K3_A_r341_B14Ckh47}
