component="$1"
dir=src/components/"$component"/index.js

echo "import $component from './$component';

export default $component;
" > "$dir"
