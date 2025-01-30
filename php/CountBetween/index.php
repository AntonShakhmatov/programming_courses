<?php

/*
 * Complete the 'countBetween' function below.
 *
 * The function is expected to return an INTEGER_ARRAY.
 * The function accepts following parameters:
 *  1. INTEGER_ARRAY arr
 *  2. INTEGER_ARRAY low
 *  3. INTEGER_ARRAY high
 */

function countBetween($arr, $low, $high) {
    $result = [];
    
    for ($i = 0; $i < count($low); $i++) {
        $count = 0;
        
        foreach ($arr as $num) {
            if ($num >= $low[$i] && $num <= $high[$i]) {
                $count++;
            }
        }
        
        $result[] = $count;
    }
    
    return $result;
}

$fptr = fopen(getenv("OUTPUT_PATH"), "w");

$arr_count = intval(trim(fgets(STDIN)));

$arr = array();

for ($i = 0; $i < $arr_count; $i++) {
    $arr_item = intval(trim(fgets(STDIN)));
    $arr[] = $arr_item;
}

$low_count = intval(trim(fgets(STDIN)));

$low = array();

for ($i = 0; $i < $low_count; $i++) {
    $low_item = intval(trim(fgets(STDIN)));
    $low[] = $low_item;
}

$high_count = intval(trim(fgets(STDIN)));

$high = array();

for ($i = 0; $i < $high_count; $i++) {
    $high_item = intval(trim(fgets(STDIN)));
    $high[] = $high_item;
}

$result = countBetween($arr, $low, $high);

fwrite($fptr, implode("\n", $result) . "\n");

fclose($fptr);