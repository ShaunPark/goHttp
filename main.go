package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", handler)

	http.ListenAndServe(":5000", nil)
}

func handler(w http.ResponseWriter, req *http.Request) {
	test := req.URL.Query().Get("test")
	println(test)
	w.Write([]byte(fmt.Sprintf("Hello world : %s", test)))
}
