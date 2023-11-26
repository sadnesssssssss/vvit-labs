import React from 'react'
import ReactDOM from 'react-dom/client'
import {ChakraProvider} from '@chakra-ui/react'
import {Pages} from './pages/index.jsx'

ReactDOM.createRoot(document.getElementById('root')).render(
    <ChakraProvider>
        <Pages/>
    </ChakraProvider>
)
