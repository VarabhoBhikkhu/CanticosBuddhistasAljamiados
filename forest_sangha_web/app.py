import os
from flask import Flask, render_template, request, redirect, url_for, abort
from content import CONTENT, MONASTERIES

app = Flask(__name__)

SUPPORTED_LANGUAGES = ['es', 'en', 'cs']
DEFAULT_LANGUAGE = 'es'

@app.context_processor
def inject_global_vars():
    """Inject language data, monasteries and helper data into all templates."""
    lang = getattr(request, 'lang', DEFAULT_LANGUAGE)
    content = CONTENT.get(lang, CONTENT[DEFAULT_LANGUAGE])
    return {
        'current_lang': lang,
        'supported_languages': SUPPORTED_LANGUAGES,
        'content': content,
        'monasteries': MONASTERIES
    }

@app.before_request
def detect_language():
    """Inspect the view args to determine active language code."""
    lang = request.view_args.get('lang') if request.view_args else None
    if lang in SUPPORTED_LANGUAGES:
        request.lang = lang
    else:
        request.lang = DEFAULT_LANGUAGE

@app.route('/')
def root():
    """Redirect root to user's preferred language or default Spanish."""
    best_match = request.accept_languages.best_match(SUPPORTED_LANGUAGES)
    target_lang = best_match if best_match else DEFAULT_LANGUAGE
    return redirect(url_for('index', lang=target_lang))

@app.route('/<lang>/')
def index(lang):
    if lang not in SUPPORTED_LANGUAGES:
        return redirect(url_for('index', lang=DEFAULT_LANGUAGE))
    return render_template('index.html', page='home')

@app.route('/<lang>/tradition')
def tradition(lang):
    if lang not in SUPPORTED_LANGUAGES:
        return redirect(url_for('tradition', lang=DEFAULT_LANGUAGE))
    return render_template('tradition.html', page='tradition')

@app.route('/<lang>/teachings')
def teachings(lang):
    if lang not in SUPPORTED_LANGUAGES:
        return redirect(url_for('teachings', lang=DEFAULT_LANGUAGE))
    return render_template('teachings.html', page='teachings')

@app.route('/<lang>/monasteries')
def monasteries(lang):
    if lang not in SUPPORTED_LANGUAGES:
        return redirect(url_for('monasteries', lang=DEFAULT_LANGUAGE))
    return render_template('monasteries.html', page='monasteries')

@app.route('/<lang>/copyright')
def copyright_view(lang):
    if lang not in SUPPORTED_LANGUAGES:
        return redirect(url_for('copyright_view', lang=DEFAULT_LANGUAGE))
    return render_template('copyright.html', page='copyright')

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)
