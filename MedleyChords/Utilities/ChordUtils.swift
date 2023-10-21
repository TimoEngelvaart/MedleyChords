import SwiftUI

func transpose(chords: String, fromKey: String, toKey: String) -> String? {
    let allKeys: [String: [String: String]] = [
        "A": ["A": "I", "Bm": "ii", "C#m": "iii", "D": "IV", "E": "V", "F#m": "vi", "G#dim": "vii°"],
        "A#": ["A#": "I", "Cm": "ii", "Dm": "iii", "D#": "IV", "F": "V", "Gm": "vi", "Adim": "vii°"],
        "Bb": ["Bb": "I", "Cm": "ii", "Dm": "iii", "Eb": "IV", "F": "V", "Gm": "vi", "Adim": "vii°"],
        "B": ["B": "I", "C#m": "ii", "D#m": "iii", "E": "IV", "F#": "V", "G#m": "vi", "A#dim": "vii°"],
        "C": ["C": "I", "Dm": "ii", "Em": "iii", "F": "IV", "G": "V", "Am": "vi", "Bdim": "vii°"],
        "C#": ["C#": "I", "D#m": "ii", "Fm": "iii", "F#": "IV", "G#": "V", "A#m": "vi", "Bdim": "vii°"],
        "Db": ["Db": "I", "Ebm": "ii", "Fm": "iii", "Gb": "IV", "Ab": "V", "Bbm": "vi", "Cdim": "vii°"],
        "D": ["D": "I", "Em": "ii", "F#m": "iii", "G": "IV", "A": "V", "Bm": "vi", "C#dim": "vii°"],
        "D#": ["D#": "I", "Fm": "ii", "Gm": "iii", "G#": "IV", "A#": "V", "Cm": "vi", "Ddim": "vii°"],
        "Eb": ["Eb": "I", "Fm": "ii", "Gm": "iii", "Ab": "IV", "Bb": "V", "Cm": "vi", "Ddim": "vii°"],
        "E": ["E": "I", "F#m": "ii", "G#m": "iii", "A": "IV", "B": "V", "C#m": "vi", "D#dim": "vii°"],
        "F": ["F": "I", "Gm": "ii", "Am": "iii", "Bb": "IV", "C": "V", "Dm": "vi", "Edim": "vii°"],
        "F#": ["F#": "I", "G#m": "ii", "A#m": "iii", "B": "IV", "C#": "V", "D#m": "vi", "Edim": "vii°"],
        "Gb": ["Gb": "I", "Abm": "ii", "Bbm": "iii", "Cb": "IV", "Db": "V", "Ebm": "vi", "Fdim": "vii°"],
        "G": ["G": "I", "Am": "ii", "Bm": "iii", "C": "IV", "D": "V", "Em": "vi", "F#dim": "vii°"],
        "G#": ["G#": "I", "A#m": "ii", "Bm": "iii", "C": "IV", "D#": "V", "Fm": "vi", "Gdim": "vii°"],
        "Ab": ["Ab": "I", "Bbm": "ii", "Cm": "iii", "Db": "IV", "Eb": "V", "Fm": "vi", "Gdim": "vii°"]
    ]

    guard let chordsInFromKey = allKeys[fromKey], let chordsInToKey = allKeys[toKey] else {
            print("Either the fromKey \(fromKey) or toKey \(toKey) was not found.")
            return nil
        }

        let chordsArray = chords.split(separator: "-").map { String($0).trimmingCharacters(in: .whitespaces) }
        var transposedChords: [String] = []
        
        for chord in chordsArray {
            guard let romanNumeral = chordsInFromKey[chord] else {
                print("Chord \(chord) not found in key \(fromKey)")
                return nil
            }
            
            guard let transposedChord = chordsInToKey.first(where: { $0.value == romanNumeral })?.key else {
                print("Transposed Roman numeral \(romanNumeral) could not be translated to a chord in key \(toKey)")
                return nil
            }

            transposedChords.append(transposedChord)
        }

        let transposedChordsString = transposedChords.joined(separator: " - ")
        return transposedChordsString
    }
