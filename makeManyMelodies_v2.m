% Making Melodies Program by Jane Plomp
% Goal: To create many melodies with a certain set of restrictions
% (Each successive note is <=7 small steps from the previous, and no
% note repeats twice. Length of melody: 8 notes)

function makeManyMelodies
% To start, must create an array with all possible tones from 1-24
% (semitones are included here for the sake of counting small steps)
allTones = [1:24];
% Now I'll make an array that indicates all valid tones, 1=valid, 0=invalid
validMajorBase = [1 0 1 0 1 1 0 1 0 1 0 1];
validMajor = [validMajorBase,validMajorBase];
% Now let's make a set of numbers that are ONLY the valid options. To do
% so, we need to choose all the notes from 1-24 in the allTones array that
% correspond to a 1 (valid) in the validMajor array
onlyValidMajor = [];
for i = 1:length(allTones)
    if validMajor(i)==1
        onlyValidMajor = cat(2,onlyValidMajor,allTones(i));
    else
    end
end

% Now that we have an array with only valid note values, let's make a
% function that can efficiently find a note.
    function n = getNote(remains)
        n = remains(randi(length(remains)));
    end

% Okay can we make an actual melody out of this?? Let's do it
    function m = makeMelody(scale)
            %Let's put the real remains in this function?
            remains = scale;
            % Make an array that will be the melody array
            melody = [];
            % Add in the first note! easy-peasy
            note1 = getNote(remains);
            % And delete that first note from remaining possible
            remains = remains(remains~=note1);
            % Add that beautiful first note into the melody!
            melody = cat(2,melody,note1);
            % For loops are HOT and make the next 7 notes easy to repeat
            for i = 2:8
                noteNew = 100; %absurdly high number, more than 7 steps away
                % While new note is greater than 7 steps away, keep choosing
                % a new note
                while abs(noteNew-melody(i-1))>7
                    noteNew = getNote(remains);
                    % But once you find a close enough note, add to meody and
                    % remove from remains!
                    if abs(noteNew-melody(i-1))<8
                        melody = cat(2,melody,noteNew);
                        remains = remains(remains~=noteNew);
                        break
                    end
                end 
            end
        m = melody;
    end

% Let's test it out!
%melodyTest = makeMelody(onlyValidMajor);
%disp(melodyTest);

% Heck yeah it worked, let's make a bunch of them into one array!
manyMelodies = [];
for i = 1:3 %can change number of melodies to generate here.
    oneMelody = makeMelody(onlyValidMajor);
    manyMelodies = cat(1,manyMelodies,oneMelody);
end

disp(manyMelodies);

% PROGRESS NOTES: Melody sometimes gets backed into a corner and errors
% into infinity... need to put a try-catch function in somewhere
% that allows one to just repeat an action until it stops working back
% Maybe in manyMelodies section? Instead of i = 1:3 could do a counter and
% continue trying again and again (catches recording nothing) until the
% counter reaches a certain number.

end