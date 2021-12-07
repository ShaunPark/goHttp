package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", handler)
	http.HandleFunc("/api/v1/users", getUserHandler)
	http.ListenAndServe(":5000", nil)
}

func handler(w http.ResponseWriter, req *http.Request) {
	test := req.URL.Query().Get("test")
	println(test)
	w.Write([]byte(fmt.Sprintf("Hello world : %s", test)))
}

func getUserHandler(w http.ResponseWriter, req *http.Request) {
	w.Header().Add("Content-Type", "application/json")
	ret := []user{}
	ret = append(ret, user{id: "test1", name: "name1"})
	ret = append(ret, user{id: "test2", name: "name2"})
	ret = append(ret, user{id: "test3", name: "name3"})
	bytes, _ := json.Marshal(ret)
	w.Write(bytes)
}

type user struct {
	id   string `json:"id"`
	name string `json:"name"`
}
