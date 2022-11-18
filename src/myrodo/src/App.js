import logo from './logo.svg';
import * as React from 'react';
import TextField from '@mui/material/TextField';
import './App.css';

import {initializeApp} from "firebase/app";
import {getFirestore} from "firebase/firestore";
import {collection, addDoc} from "firebase/firestore";
import {Button, FormControlLabel, FormGroup, Switch} from "@mui/material";

const firebaseConfig = {
    apiKey: "AIzaSyANgfQsAVKczON6ZX7lCM-giW8vUdr24_s",
    authDomain: "myrodo-92490.firebaseapp.com",
    projectId: "myrodo-92490",
    storageBucket: "myrodo-92490.appspot.com",
    messagingSenderId: "240007571497",
    appId: "1:240007571497:web:f42887e0530ecc4b9a9438",
    measurementId: "G-TJTYNCRCD3"
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

async function add_document(data) {
    try {
        const docRef = await addDoc(collection(db, "restaurants"), data);
        console.log("Document written with ID: ", docRef.id);
    } catch (e) {
        console.error("Error adding document: ", e);
    }
}

function App() {
    let data = {}
    let form_fields = [
        {label: "City", tag: "city", default: "Gent"},
        {label: "Country", tag: "country", default: "Belgium"},
        {label: "Image Name", tag: "image_name", default: "caferene"},
        {label: "Name", tag: "name", default: "Café René"},
        {label: "Postal Code", tag: "postal_code", default: "9000"},
        {label: "Rating", tag: "rating", default: "4.3"},
        {label: "Street", tag: "street", default: "Geostreet"},
        {label: "Number", tag: "street_number", default: "75"},
    ]
    // let legacy = {
    //     city: "Gent",
    //     country: "Belgium",
    //     image_name: "caferene",
    //     is_favorite: false,
    //     name: "Café René",
    //     postal_code: "9000",
    //     rating: "4.3",
    //     street: "Geostreet",
    //     street_number: "27",
    // }

    const handleChange = (event, tag) => {
        data[tag] = event.target.value;
    }

    return (
        <div className="App">
            <header className="App-header">
                <img src={logo} className="App-logo" alt="logo"/>
            </header>
            <body>
            <FormGroup>
                {form_fields.map(field => {
                    data[field.tag] = field.default;
                    return (
                        <div className="Textfield">
                            <TextField
                                id={field.tag}
                                label={field.label}
                                defaultValue={field.default}
                                onChange={event => handleChange(event, field.tag)}
                            />
                        </div>
                    );
                })}
                <FormControlLabel
                    control={<Switch/>}
                    label="Favorite"
                    checked={false}
                    onChange={(event) =>
                        data["is_favorite"] = event.target.checked
                    }/>
            </FormGroup>
            <Button onClick={(event) => add_document(data)}>Add Document</Button>
            </body>
        </div>
    );
}

export default App;
