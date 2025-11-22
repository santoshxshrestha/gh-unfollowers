#!/usr/bin/env nu

def fetch_all_pages [url: string, headers?: record] {
    mut all_data = []
    mut page = 1
    mut per_page = 100
    
    loop {
        let page_url = $"($url)?per_page=($per_page)&page=($page)"
        
        let data = if ($headers != null) {
            http get -H $headers $page_url
        } else {
            http get $page_url
        }
        
        if ($data | length) == 0 {
            break
        }
        
        $all_data = ($all_data | append $data)
        
        if ($data | length) < $per_page {
            break
        }
        
        $page = $page + 1
    }
    
    $all_data
}

let username = (input "Enter a GitHub username: ")
let token = (input "Enter your GitHub PAT (optional untill you reach API rate limit, press Enter to skip): ")

if $token == "" {
    let following = (fetch_all_pages $"https://api.github.com/users/($username)/following")

    let followers = (fetch_all_pages $"https://api.github.com/users/($username)/followers")

    let result = $following | where {
        |x| not ($followers | any {
            |y| $x == $y
        })
    }

    $result | select login html_url | table
} else {

    let headers = { Authorization: $token }

    let following = (fetch_all_pages $"https://api.github.com/users/($username)/following" $headers)

    let followers = (fetch_all_pages $"https://api.github.com/users/($username)/followers" $headers)

    let result = $following | where {
        |x| not ($followers | any {
            |y| $x == $y
        })
    }

    $result | select login html_url | table

}

