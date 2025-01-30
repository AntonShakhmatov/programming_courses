API JS:
'use strict';

import * as fs from 'fs';
import * as readline from 'readline';
import axios from 'axios';

// Create a readline interface for reading input
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let inputLines: string[] = [];
rl.on('line', (input: string) => {
    inputLines.push(input);
});
rl.on('close', () => {
    main();
});

function readLine(): string {
    return inputLines.shift()  '';
}

/*
 * Complete the 'getPhoneNumbers' function below.
 *
 * The function is expected to return a STRING.
 * The function accepts following parameters:
 *  1. STRING country
 *  2. STRING phoneNumber
 * Base URL for copy/paste: https://jsonmock.hackerrank.com/api/countries?name=country 
 */

async function getPhoneNumbers(country: string, phoneNumber: string): Promise<string> {
    const baseURL = `https://jsonmock.hackerrank.com/api/countries?name=${encodeURIComponent(country)}`;
    try {
        // Fetch data using axios
        const response = await axios.get(baseURL);
        const data = response.data;

        // Check if the data array is empty
        if (!data.data  data.data.length === 0) {
            return "-1";
        }

        // Extract country data
        const countryData = data.data[0];

        // Check for calling codes
        if (countryData.callingCodes && countryData.callingCodes.length > 0) {
            const callingCode = countryData.callingCodes[countryData.callingCodes.length - 1];
            return +${callingCode} ${phoneNumber};
        }

        return "-1";
    } catch (error) {
        console.error("Error fetching country data:", error.message);
        return "-1";
    }
}

async function main() {
    const ws = fs.createWriteStream(process.env['OUTPUT_PATH'] || './output.txt');

    const country: string = readLine();
    const phoneNumber: string = readLine();

    const result: string = await getPhoneNumbers(country, phoneNumber);

    ws.write(result + '\n');
    ws.end();
}