import re

class AljamiadoTranscriber:
    """
    A basic transcriber for Spanish to Aljamiado (Arabic script).
    Based on simplified phonetic mapping.
    """
    
    # Mapping of Spanish phonemes/graphemes to Arabic characters
    # This is a simplified model for demonstration.
    MAPPING = {
        'a': 'ا',
        'b': 'ب',
        'c': 'ك', # simplified: c before e,i is 's', before a,o,u is 'k'
        'd': 'د',
        'e': 'ي', # mapped to ya for vowel sounds
        'f': 'ف',
        'g': 'ج', # simplified
        'h': 'ه',
        'i': 'ي',
        'j': 'خ', # Aljamiado often used kha for Spanish j/g(e,i)
        'k': 'ك',
        'l': 'ل',
        'm': 'م',
        'n': 'ن',
        'ñ': 'ني', # approximation
        'o': 'و',
        'p': 'ب', # Arabic lacks 'p', usually uses 'b'
        'q': 'ق',
        'r': 'ر',
        's': 'س',
        't': 'ت',
        'u': 'و',
        'v': 'ب', # Arabic lacks 'v', usually uses 'b'
        'w': 'و',
        'x': 'كس',
        'y': 'ي',
        'z': 'ز',
        ' ': ' ',
    }

    def transcribe(self, text):
        text = text.lower()
        # Handle specific Spanish phonetics
        # 'ce' / 'ci' -> 's'
        text = re.sub(r'c([ei])', r's\1', text)
        # 'll' -> 'ly' approximation
        text = text.replace('ll', 'ly')
        # 'ch' -> 'ch' approximation
        text = text.replace('ch', 'tsh')
        
        result = []
        for char in text:
            result.append(self.MAPPING.get(char, char))
            
        # Join and reverse because Arabic is RTL, 
        # but usually, strings are stored logically.
        # For a CLI tool, we return the logical string.
        return "".join(result)

def transcribe_spanish_to_aljamiado(text):
    transcriber = AljamiadoTranscriber()
    return transcriber.transcribe(text)

if __name__ == "__main__":
    test_texts = ["Hola", "Buddhismo", "Aljamiado"]
    for t in test_texts:
        print(f"{t} -> {transcribe_spanish_to_aljamiado(t)}")
