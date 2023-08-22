import random
import time
from googletrans import Translator, LANGUAGES

class AllergyTranslator:
    def __init__(self):
        self.translator = Translator()
        self.languages = self._get_languages()

    def _get_languages(self):
        """Return a list of language codes for translation."""
        # Top 20 most spoken languages and European languages
        languages = [
            'af', 'sq', 'am', 'ar', 'hy', 'az', 'eu', 'be', 'bn', 'bs',
            'bg', 'ca', 'ceb', 'zh-cn', 'zh-tw', 'co', 'hr', 'cs', 'da', 'nl',
            'eo', 'et', 'fi', 'fr', 'fy', 'gl', 'ka', 'de', 'el',
            'gu', 'ht', 'ha', 'haw', 'he', 'hi', 'hmn', 'hu', 'is', 'ig',
            'id', 'ga', 'it', 'ja', 'jw', 'kn', 'kk', 'km', 'ko', 'ku',
            'ky', 'lo', 'la', 'lv', 'lt', 'lb', 'mk', 'mg', 'ms', 'ml',
            'mt', 'mi', 'mr', 'mn', 'my', 'ne', 'no', 'ny', 'ps', 'fa',
            'pl', 'pt', 'pa', 'ro', 'ru', 'sm', 'gd', 'sr', 'st', 'sn',
            'sd', 'si', 'sk', 'sl', 'so', 'es', 'su', 'sw', 'sv', 'tl',
            'tg', 'ta', 'te', 'th', 'tr', 'uk', 'ur', 'ug', 'uz', 'vi',
            'cy', 'xh', 'yi', 'zu'
        ]
        return languages

    def translate_allergies(self, allergies):
        """Translate a list of allergies into multiple languages."""
        translations = {}
        for allergy in allergies:
            translations[allergy] = self._translate_phrase(allergy)
        return translations

    def _translate_phrase(self, phrase):
        """Translate a phrase into multiple languages."""
        translations = {}
        delay_schedules = [(5, 10), (30, 60), (60, 120)]

        for lang in self.languages:
            lang_name = LANGUAGES[lang]
        
            for delay_range in delay_schedules:
                try:
                    translated_text = self.translator.translate(phrase, dest=lang).text
                    translations[lang_name] = translated_text
                    break  # Exit the loop if translation is successful
                except Exception as e:
                    min_delay, max_delay = delay_range
                    wait_time = random.uniform(min_delay, max_delay)
                    print(f"Error while translating '{phrase}' to {lang_name}. Retrying in {wait_time:.2f} seconds...")
                    time.sleep(wait_time)
            else:
                print(f"Failed to translate '{phrase}' to {lang_name} after multiple retries.")
            
        return translations

    def save_translations_to_file(self, translations, filename):
        """Save translations to a specified file."""
        with open(filename, "w", encoding="utf-8") as file:
            for key, translated_phrases in translations.items():
                translations_list = [
                    f'"{lang.capitalize()}": "{translation}"'
                    for lang, translation in translated_phrases.items()
                ]
                file.write(f'"{key}": [{", ".join(translations_list)}]\n')


if __name__ == "__main__":
    translator = AllergyTranslator()

    # Translate allergies
    allergies = ["milk", "eggs", "peanuts", "tree nuts", "fish", "shellfish", "soy", "wheat", "sesame"]
    allergy_translations = translator.translate_allergies(allergies)
    translator.save_translations_to_file(allergy_translations, "translated_ings.txt")

    # Translate the statement
    phrase = "I am allergic to some ingredients. I can not eat food containing the following foods:"
    statement_translations = {"Statement": translator._translate_phrase(phrase)}
    translator.save_translations_to_file(statement_translations, "translated_phrase.txt")
