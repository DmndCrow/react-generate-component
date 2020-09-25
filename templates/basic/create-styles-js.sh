component="$1"
dir=src/components/"$component"/styles.js

echo "import React from 'react';
import styled from 'styled-components';

const Div = styled.div\`

\`;

export {
  Div
};

" > "$dir"
