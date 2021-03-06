# react-generate-component
react-generate-component is the npm package for dynamic component generation using bash script (build.sh). By providing component name (or names, splitted by space), new component will be generated in src/components/ directory. It can be further extended by creating new templates using examples from __basic__ and __redux__ templates.

By default, package uses __basic__ template and if no component name provided, _Template_ named component will be generated.

Note that this component uses _styled-components_, and if you want to change it, feel free to update __templates/__ folder.

Note: the scripts are bash scripts and may not run on Windows machines. If that is the case, please use Git Bash.

### Installation
```
sudo npm install -g @dmndcrow/react-generate-component
```

### Open react app and type in root directory
```
react-generate-component {-h | --help} {-t | --type template_name} {component_name}
```

### Example
```
react-generate-component -t redux ReduxComponent
```

will generate
```
src
├── components
    ├── ReduxComponent
        ├── index.js
        ├── ReduxComponent.js
        ├── styles.js
```

where each file depends on provided template.
