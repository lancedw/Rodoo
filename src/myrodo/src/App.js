import logo from './logo.svg';
import * as React from 'react';
import TextField from '@mui/material/TextField';
import './App.css';

function App() {
    return (
        <div className="App">
            <header className="App-header">
                <img src={logo} className="App-logo" alt="logo"/>
            </header>
            <body >
                <form>
                    <TextField
                        id="outlined-required"
                        label="Restaurant name"
                        defaultValue="Restaurant name"
                    />
                </form>
            </body>
        </div>
    );
}

export default App;
