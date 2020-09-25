component="$1"
dir=src/components/"$component"/"$component".js

echo "import React, { useEffect, useState } from 'react';
import propTypes from 'prop-types';
import { useDispatch, useSelector } from 'react-redux';
import { Div } from 'styles.js';

const $component = (props) => {
  const dispatch = useDispatch();
  const [val, setVal] = useState(null);

  useEffect(() => {

  }, []);

  return (
    <Div>styled div $component</Div>
  );
};

$component.PropTypes = {

};

export default $component;
" > "$dir"


