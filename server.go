package main

import (
    "fmt"
    "net/http"
)

func helloWorld(w http.ResponseWriter, r *http.Request){
    fmt.Fprintf(w, "Hellow World 22 março 2024!")
}

func main() {
    http.HandleFunc("/", helloWorld)
    http.ListenAndServe(":8080", nil)
}
