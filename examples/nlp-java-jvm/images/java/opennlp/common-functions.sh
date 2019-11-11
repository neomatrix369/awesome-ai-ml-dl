language=en
MODEL_VERSION=1.5

APACHE_OPENNLP_VERSION=1.9.1
SHARED_FOLDER="../shared/"
URL_PREFIX="http://opennlp.sourceforge.net/models-"
OPENNLP_BINARY="${SHARED_FOLDER}/apache-opennlp-${APACHE_OPENNLP_VERSION}/bin/opennlp"

checkIfApacheOpenNLPIsPresent() {
  if [[ ! -s "${OPENNLP_BINARY}" ]]; then
    echo "Can't find "${OPENNLP_BINARY}" needed to run this action."
    echo "Please run the docker container (see usage of the docker-runner.sh script in the previous folder)."
    echo "Or run the opennlp.sh script in this folder, and try again..."
    exit -1
  fi
}

downloadModel() {
	echo "Checking if model ${MODEL_FILENAME} (${language}) exists..."
	if [[ -s "${SHARED_FOLDER}/${MODEL_FILENAME}" ]]; then
		echo "Found model ${MODEL_FILENAME} (${language})"
	else
		echo "Downloading model ${MODEL_FILENAME} (${language})..."
		curl -O -J -L \
		     "${URL_PREFIX}${MODEL_VERSION}/${MODEL_FILENAME}"
    mkdir -p ${SHARED_FOLDER}
    mv ${MODEL_FILENAME} ${SHARED_FOLDER}
	fi
}

checkIfNoParamHasBeenPassedIn() {
	if [[ $1 -eq 0 ]]; then
		echo "No parameter has been passed. Please see usage below:"
		echo "";
		showUsageText
	fi
}

checkIfNoActionParamHasBeenPassedIn() {
	if [[ $1 -eq 0 ]]; then
		echo "No command action passed in as parameter. Please see usage below:"
		echo "";
		showUsageText
	fi	
}

showHelpForTagLegend() {
  echo ""; 
  echo "Check out https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html 
  to find out what each of the tags mean"
}

showHelpForLanguageLegend() {
  echo ""; 
  echo "Check out https://www.apache.org/dist/opennlp/models/langdetect/1.8.3/README.txt to find out what each of the two-letter language indicators mean"
}