# generation type
type="basic"


# if component name is not specified, create Template
if [ -n "$1" ]; then
  component=$1
else
  component="Template"
fi

srcDirectoryValidation() {
  dir="src"
  if [ -d "$dir" ]; then
    # Continue if $DIR exists. #
    echo "Installing component files in ${dir}..."
  else
    #  exit from bash script if $DIR does NOT exists ###
    echo "Error: ${dir} not found. Can not continue."
    exit 1
  fi
}

componentsDirectoryValidation() {
  DIR="src/components"
  if [ -d "$DIR" ]; then
    # Continue if $DIR exists. #
    echo "Installing component files in ${DIR}..."
  else
    #  exit from bash script if $DIR does NOT exists ###
    echo "Warning: ${DIR} not found. Creating..."
    mkdir "$DIR"
  fi
}

newComponentDirectoryValidation() {
  dir="src/components/${1}"
  if [ -d "$dir" ]; then
    # Continue if $DIR exists. #
    echo "Error: ${dir} is found. Can not continue"
    exit 1
  else
    #  exit from bash script if $DIR does NOT exists ###
    echo "Installing component files in ${dir}..."
    mkdir "$dir"
  fi
}

generateComponentFiles() {
  repo_path="$1"
  type="$2"
  component="$3"

  template_path="$repo_path"/templates/"$type"

  sh "$template_path"/create-styles-js.sh "$component"

  sh "$template_path"/create-component-js.sh "$component"

  sh "$template_path"/create-index-js.sh "$component"

}

run() {
	# args
	repo_path="$1"
	type="$2"
	component="$3"

  # check if src directory exists in current path
	srcDirectoryValidation

	# check if src/components directory exists
	componentsDirectoryValidation

	# check if passed folder exist
	newComponentDirectoryValidation "$component"

	# start component creation
	generateComponentFiles "$repo_path" "$type" "$component"
}


# get location of build.sh
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
repo_path="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

run "$repo_path" "$type" "$component"
