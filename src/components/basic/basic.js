import React, { useEffect, useState } from 'react';
import propTypes from 'prop-types';
import { Div } from 'styles.js';

const basic = (props) => {
  const [val, setVal] = useState(null);

  useEffect(() => {

  }, []);

  return (
    <Div>styled div basic</Div>
  );
};

basic.PropTypes = {

};

export default basic;

