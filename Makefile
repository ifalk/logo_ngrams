### Makefile --- 

## Author: falk@lormoral
## Version: $Id: Makefile,v 0.0 2013/04/05 13:27:47 falk Exp $
## Keywords: 
## X-URL: 

HOME_DIR=/home/falk/Logoscope/VC/logo_ngrams
LOGO_DIR=/home/falk/Logoscope/VC/logoscope_2
SCRIPT_DIR=${HOME_DIR}/bin
KNOWN_FORMS=${LOGO_DIR}/merged_known_forms_ws.txt

# - with punctuation characters
# - ^ is beginning of word
# - $ is end of word
# - no ngram containing spaces
# - words are not lowercased

# Max ngram count: 133489
# Number of ngrams: 185658

3grams.pl 3grams.csv: ${SCRIPT_DIR}/make_ngrams.pl ${KNOWN_FORMS}
	perl $< --n=3 ${KNOWN_FORMS} --csv_out=3grams.csv > 3grams.pl

### Makefile ends here
