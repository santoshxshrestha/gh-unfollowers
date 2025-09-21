#!/usr/bin/env nu

let username = (input "Enter a GitHub username: ")
let token = (input "Enter your GitHub PAT (optional untill you reach API rate limit, press Enter to skip): ")

if $token == "" {
    let following = (http get https://api.github.com/users/($username)/following)

    let followers = (http get https://api.github.com/users/($username)/followers)

    let result = $following | where {
        |x| not ($followers | any {
            |y| $x == $y
        })
    }

    $result | select login html_url | table
} else {

    let headers = { Authorization: $token }

    let following = (http get -H $headers https://api.github.com/users/($username)/following)

    let followers = (http get -H $headers https://api.github.com/users/($username)/followers)

    let result = $following | where {
        |x| not ($followers | any {
            |y| $x == $y
        })
    }

    $result | select login html_url | table

}

