help_text="usage: react-generate-component [option] [component_name]
Options:
-t | --type template_name : select required template from templates/ folder (default = basic)
component_name            : setup component name that will be generated (default = Template)
"


function getArgs() {
  # template type
  type="basic"
  # component name
  component="Template"


  PARSED_ARGUMENTS=$(getopt -a -n build -o ht: --long help,type: -- "$@")
  VALID_ARGUMENTS=$?
  if [ "$VALID_ARGUMENTS" != "0" ]; then
    usage
  fi

  eval set -- "$PARSED_ARGUMENTS"
  while :
  do
    case "$1" in
      -h | --help) help=1   ; shift   ;;
      -t | --type) type="$2"; shift 2 ;;
      # -- means the end of the arguments; drop this, and break out of the while loop
      --) shift; break ;;
      # If invalid options were passed, then getopt should have reported an error,
      # which we checked as VALID_ARGUMENTS when getopt was called...
      *) echo "Unexpected option: $1 - this should not happen."
         usage ;;
    esac
  done

  if [ $# -gt 0 ]; then
    component=""
  fi

  for args in "${@^}"
  do
      component=${component:+$component}$args
  done
}

getArgs "$@"

if [ "${help}" ]; then
  echo "$help_text"
  exit 1
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

templatesDirectoryValidation() {
  repo_path="$1"
  type="$2"
  dir="$repo_path"/templates/"$type"

  if [ ! -d "$dir" ]; then
    echo "Error: ${dir}. Template does NOT exist;"
    exit 1
  fi
}

componentsDirectoryValidation() {
  dir="src/components"
  if [ -d "$dir" ]; then
    # Continue if $dir exists. #
    echo "Installing component files in ${dir}..."
  else
    #  exit from bash script if $dir does NOT exists ###
    echo "Warning: ${dir} not found. Creating..."
    mkdir "$dir"
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

	# check if templates folder exists
	templatesDirectoryValidation "$repo_path" "$type"

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
