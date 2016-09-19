# Write-up Blue Monday IceCTF 2016

This challenge provided a file called "blue_monday". To identify what type of file this is I used:
> file blue_monday

It appeared to contain Standard MIDI data. The extension of the file was changed to *.midi, resulting in a playable MIDI-file. The MIDI-file only appeared to contain some random music notes.
That was the moment I concluded it could be possible the data in the MIDI-file, defining the notes to play, contains the flag.

Using this website: http://www.ccarh.org/courses/253/handout/smf/ where I found the Standard MIDI file structure definition, I found the following:
(Used 010 Editor with the MIDI template (http://www.sweetscape.com/010editor/repository/files/MIDI.bt))
* Section "tracks" contained most of the data;
* Every track event in this "tracks" section contains note_on & note_off events;
* The characters defined in those note_off events as notes to play are in order the flag.

For example a track event is shown below (hexadecimal): <br/>
81 5C 80 49 00

The structure of such a track event is:<br/>
char t0[1]; <br/>
char t1[1]; <br/>
char m_status[1]; <br/>
char m_note[1]; <br/>
char m_velocity[1]; <br/>

For every track event exists a char m_note with byte length of 1. When you put the char m_note of track events with a note_off event in order you get the following flag:
> IceCTF{HAck1n9_mU5Ic_W17h_mID15_L3t5_H4vE_a_r4v3}
